//
//  MapView.swift
//  Starbucks
//
//  Created by nau on 5/3/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var viewModel = MapViewModel()
    @Bindable private var locationManager: LocationManager = .shared
    
    @State private var lastKnownLocation: CLLocationCoordinate2D? // 이전 카메라 위치 저장
   
    @Namespace var mapScope // 맵 관련 스코프 바인딩용
    
    /*
     @State private var showEnteredAlert: Bool = false
    @State private var showExitedAlert: Bool = false // 지오펜스 알림 제어
    */
    
    @State private var hasMovedMap = false // 사용자가 지도를 움직였는지..
    @State private var hasInitializedCameraPosition = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(position: $viewModel.cameraPosition, scope: mapScope) {
                // 마커 표시
                ForEach(viewModel.makers, id: \.id, content: { marker in
                    Annotation(marker.title, coordinate: marker.coordinate, content: {
                        Image(.marker)
                            .resizable()
                            .frame(width: 35, height: 48)
                    })
                })
                
                // 내 위치에 점을 지도에 표시
                UserAnnotation()
                
                //지정한 반경을 지도에 원으로 표시
                /*MapCircle(center: viewModel.geofenceCoordinate, radius: viewModel.geofenceRadius)
                    .foregroundStyle(Color.blue.opacity(0.2))
                    .stroke(Color.blue, lineWidth: 2)
                 */
            }
            // 사용자가 지정한 영역에 들어가거나 나가면 3초동안 알림 표시
            /*
            .onChange(of: locationManager.didEnterGeofence) { _, entered in
                if entered {
                    showEnteredAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showEnteredAlert = false
                        locationManager.didEnterGeofence = false
                    }
                }
            }
            
            .onChange(of: locationManager.didExitGeofence) { _, exited in
                if exited {
                    showExitedAlert = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        showExitedAlert = false
                        locationManager.didExitGeofence = false
                    }
                }
            }*/
            .task {
                if !hasInitializedCameraPosition,
                   let location = LocationManager.shared.currentLocation {
                    viewModel.cameraPosition = .region(
                        MKCoordinateRegion(
                            center: location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )
                    )
                    hasInitializedCameraPosition = true
                }
            }
            // 지도 움직임 감지
            .onMapCameraChange(frequency: .onEnd) { context in
                let center = context.camera.centerCoordinate
                
                if let last = lastKnownLocation {
                    let movedDistance = CLLocation(latitude: last.latitude, longitude: last.longitude).distance(from: CLLocation(latitude: center.latitude, longitude: center.longitude))
                    
                    if movedDistance >= 50 {
                        hasMovedMap = true
                    }
                }
                lastKnownLocation = center
            }

            
            VStack {
                if hasMovedMap {
                    Button {
                        // 이 지역에서 재검색하는 로직
                        print("이 지역 검색 버튼 눌림")
                        if let newCenter = lastKnownLocation {
                            let location = CLLocation(latitude: newCenter.latitude, longitude: newCenter.longitude)
                            
                            viewModel.loadMarkersFromGeoJSON(userLocation: location)
                            
                            viewModel.cameraPosition = .region(
                                MKCoordinateRegion(center: newCenter, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)))
                            
                            hasMovedMap = false
                                
                        }
                    } label: {
                        Text("이 지역 검색")
                            .padding()
                            .background(.white)
                            .font(.mainTextMedium12)
                            .foregroundStyle(.gray06)
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                    .frame(width: 88)
                    .offset(x: -UIScreen.screenSize.width/2 + 44, y: 10)
                }
                
                Spacer()
                
                // 오른쪽 아래에 내 위치로 이동 버튼 배치
                MapUserLocationButton(scope: mapScope)
                    .overlay(content: {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.clear)
                    })
                    .offset(x: -10, y: -10)
            }
            // 지오펜스 알림
            /*if showEnteredAlert {
                HStack {
                    Spacer()
                    Text("\(viewModel.geofenceIdentifier) 진입함")
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                    Spacer()
                }
            }

            if showExitedAlert {
                HStack {
                    Spacer()
                    Text("\(viewModel.geofenceIdentifier) 벗어남")
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                    Spacer()
                }
            }*/
        }
        .mapScope(mapScope)
        /*.overlay(alignment: .top, content: {
            VStack(content: {
                HStack(spacing: 10) {
                    Text("속도: \(locationManager.currentSpeed, specifier: "%.2f") m/s")
                    
                    Text("방향: \(locationManager.currentDirection, specifier: "%.0f")°")
                }
            })
        })*/
    }
}

#Preview {
    MapView()
}
