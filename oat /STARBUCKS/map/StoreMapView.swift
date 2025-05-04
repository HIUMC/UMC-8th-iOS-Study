//
//  StoreMapView.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/29/25.
//
import SwiftUI
import MapKit //지도띄우기
import CoreLocation // 위치 정보 다루기

// Equatable 을 붙여서 latitude, longitude 둘 다 같으면 같다고 표시
extension CLLocationCoordinate2D: Equatable {
    public static func == (l: CLLocationCoordinate2D, r: CLLocationCoordinate2D) -> Bool {
        l.latitude == r.latitude && l.longitude == r.longitude
    }
}

struct StoreMapView: View {
    @State private var region = MKCoordinateRegion(
        //지도 중심
        center: .init(latitude: 37.5665, longitude: 126.9780),
        //서울 시청 좌표
        span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var locationManager = CLLocationManager()
    @State private var hasMoved = false //지도가 움직였는지 확인하는 변수
    //false : 안움직임 , true : 움직임
    
    @State private var displayedStores: [Store] = []
    //지도에 찍힐 매장의 배열
    //10km 안에 있는 매장만 이 배열에 담김
    
    var stores: [Store] // 전체 매장 데이터
    
    var body: some View {
        ZStack {
            // 지도
            Map(
                coordinateRegion: $region,
                interactionModes: .all, // 확대,축소,드래그 허용
                showsUserLocation: true, // 점으로 내 위치 표시
                annotationItems: displayedStores // 표시할 매장만큼 마커 표시
            ) { store in
                MapAnnotation(
                    //마커 : 매장 좌표에 마커 찍음
                    coordinate: .init(latitude: store.latitude, longitude: store.longitude)
                ) {
                    ZStack { //마커 디자인
                        Image(systemName: "mappin.circle.fill")
                            .resizable().frame(width: 44, height: 44)
                            .foregroundColor(Color("green03"))
                        Image("starbuckLogo")
                            .resizable().scaledToFit().frame(width: 20, height: 20)
                    }
                }
            }

            .onAppear {
                //지도가 뜨면 : 1. 위치 권한 요청 2. 내 위치 계속 추적
                locationManager.requestWhenInUseAuthorization()
                locationManager.startUpdatingLocation()
                if let coord = locationManager.location?.coordinate {
                    region.center = coord
                }
                
                // 처음 필터링 해서 보여줌
                updateDisplayedStores()
            }
            
            //제스처 감지
            .gesture(
                //지도 움직이면 반응
                DragGesture().onChanged { _ in
                    hasMoved = true
                }
            )
            //지도 중심 좌표가 바뀌면 반응
            .onChange(of: region.center) { _ in
                hasMoved = true
                
            }
            .ignoresSafeArea()

            // 반경 10km 원 그리기
            GeometryReader { geo in
                let metersPerDegree = 111_000.0
                let mapWidthMeters = region.span.longitudeDelta * metersPerDegree
                let metersPerPoint = mapWidthMeters / geo.size.width
                let diameter = (10_000 * 2) / metersPerPoint
                
                // 계산한 크기로 원 그리기
                Circle()
                    .frame(width: diameter, height: diameter)
                    .position(x: geo.size.width / 2, y: geo.size.height / 2)
            }
            .allowsHitTesting(false) // 원이 터치 방해 안하게

            // 이 지역 검색 버튼
            if hasMoved {
                VStack {
                    Button("이 지역 검색") {
                        updateDisplayedStores() // 다시 10km 매장 필터링
                        hasMoved = false //지도 움직이면 버튼 true가 됨.
                    }
                    .font(.mainTextMedium12)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color.white)
                    .foregroundStyle(.gray06)
                    .clipShape(Capsule())
                    .shadow(radius: 4)
                    .padding(.top, 30)
                    Spacer()
                }
                .transition(.move(edge: .top))
                .animation(.easeInOut, value: hasMoved)
            }
        }
    }
    
    // 매장 필터링 함수
    private func updateDisplayedStores() {
        // 지도 중심 좌표를 가져온 뒤, 매장 하나씩 10km 인지 계산 
        let base = CLLocation(latitude: region.center.latitude,
                              longitude: region.center.longitude)
        displayedStores = stores.filter {
            let loc = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
            return base.distance(from: loc) / 1000 <= 10
        }
    }
}

#Preview {
    StoreMapView(stores: [])
}
