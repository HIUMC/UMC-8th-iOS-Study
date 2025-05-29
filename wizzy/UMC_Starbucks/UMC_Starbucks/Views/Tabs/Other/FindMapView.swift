import SwiftUI
import CoreLocation
import MapKit

struct FindMapView: View {
    @Binding var selectedTab: Int
    @StateObject var locationViewModel = SearchLocationViewModel() //state 로 할 땐 뷰 안 떴는데 stateObject 로 하니까 왜 되지
    @StateObject var storeSearchViewModel = StarbucksGeoStoreViewModel()
    @StateObject var routeVM = RouteViewModel()
    @State private var isLoading = false
    @State private var searchingRoute = false
    
    @State private var showNoResultAlert = false
    
    @Bindable var locationManager = LocationManager.shared
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("출발")
                            .font(.PretendardSemiBold16)
                        //.padding(.trailing, 5)
                        Button(action: {
                            LocationManager.shared.fetchCurrentAddress { address in
                                if let address = address {
                                    locationViewModel.startPoint = address
                                } else {
                                    locationViewModel.startPoint = "주소를 가져올 수 없습니다"
                                }
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .frame(width: 46)
                                    .foregroundStyle(Color.brown01)
                                Text("현재위치")
                                    .font(.PretendardSemiBold13)
                                    .foregroundStyle(Color.white)
                            }
                        }
                        StartPoint
                        Button(action: {
                            locationViewModel.searchKeywordLocation(query: locationViewModel.startPoint)
                        }) {
                            Image("search")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)//h
                    .padding(.bottom, 13)
                    HStack {
                        Text("도착")
                            .font(.PretendardSemiBold16)
                        //.padding(.trailing, 5)
                        
                        EndPoint
                        Button(action: {
                            storeSearchViewModel.searchLocalStore(query: storeSearchViewModel.keyword)
                        }) {
                            Image("search")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 30)//h
                    .padding(.bottom, 18)
                    
                    Button(action: {
                        isLoading = true
                        geocodeAddresses()
                    }) {
                        Text("경로 찾기")
                            .font(.PretendardMedium16)
                            .frame(maxWidth: .infinity, minHeight: 38) //크기 정하고 배경 정하고 코너 깎기
                            .background(Color.green00)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }// 버튼 뷰
                }
                .frame(maxWidth: .infinity, alignment: .top)
                .padding(.horizontal, 35)
                .padding(.top, 20)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        if !locationViewModel.storeList.isEmpty {
                            ForEach(locationViewModel.storeList, id: \.id) { store in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(store.placeName)
                                        .font(.PretendardMedium16)
                                    Text(store.roadAddressName)
                                        .font(.PretendardRegular13)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.vertical, 8)
                                .onTapGesture {
                                    locationViewModel.startPoint = store.placeName
                                    locationViewModel.startRoad = store.roadAddressName
                                    locationViewModel.selectedStartStore = store
                                    locationViewModel.storeList = []
                                }
                                Divider()
                            }
                        }
                        if !storeSearchViewModel.starbucksStoreList.isEmpty {
                            ForEach(storeSearchViewModel.starbucksStoreList, id: \.id) { store in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(store.name)
                                        .font(.PretendardMedium16)
                                    Text(store.address)
                                        .font(.PretendardRegular13)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.vertical, 8)
                                .onTapGesture {
                                    storeSearchViewModel.keyword = store.name
                                    storeSearchViewModel.endRoad = store.address //도로명 주소를 startRoad에 저장
                                    storeSearchViewModel.selectedEndStore = store
                                    storeSearchViewModel.starbucksStoreList = [] //검색 결과 리스트를 즉시 숨기기 위해 비우는 작업
                                }
                                Divider()
                            }
                        }
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 35)
                }
            }

            
            if selectedTab == 0 {
                RouteMapView(viewModel: routeVM)
                    .edgesIgnoringSafeArea(.all)
            }
             

            if searchingRoute {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                ProgressView("경로 불러오는 중...")
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            
            if storeSearchViewModel.showNoResultAlert {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    Text("검색 결과가 존재하지 않습니다.")
                        .font(.system(size: 15))
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .multilineTextAlignment(.center)
                    Divider()
                    Button(action: {
                        storeSearchViewModel.showNoResultAlert = false
                    }) {
                        Text("확인")
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .foregroundColor(.green00)
                    }
                }
                .frame(width: 280)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 6)
            }
        }
    }
    
    
    
    
    private var StartPoint: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .stroke(Color.gray)
                .frame(height: 36)
            TextField(
                "출발지 입력", // 접근성용
                text: $locationViewModel.startPoint,
                prompt: Text("출발지 입력")
                    .font(.PretendardRegular13)
                    .foregroundStyle(Color.signupGray)
                    .kerning(-0.65)
            )
            .padding(.horizontal, 10)
        }
    }
    
    private var EndPoint: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .stroke(Color.gray)
                .frame(height: 36)
            TextField(
                "도착지 입력", // 접근성용
                text: $storeSearchViewModel.keyword,
                prompt: Text("매장명 또는 주소")
                    .font(.PretendardRegular13)
                    .foregroundStyle(Color.signupGray)
                    .kerning(-0.65)
            )
            .padding(.horizontal, 10)
        }
    }
    
    func geocodeAddresses() {
        print("📝 출발지 문자열: \(locationViewModel.startRoad)")
        print("📝 도착지 문자열: \(storeSearchViewModel.endRoad)")
        searchingRoute = true

        print("🔍 selectedStartStore: \(String(describing: locationViewModel.selectedStartStore))")
        print("🔍 starbucksStoreList.first: \(String(describing: storeSearchViewModel.starbucksStoreList.first))")
        guard
            let startStore = locationViewModel.selectedStartStore,
            let endStore = storeSearchViewModel.selectedEndStore,
            let startX = Double(startStore.x),
            let startY = Double(startStore.y),
            let endX = Double(endStore.x),
            let endY = Double(endStore.y)
        else {
            print("❌ 좌표 정보 부족으로 경로 요청 실패")
            searchingRoute = false
            return
        }

        let startCoord = CLLocationCoordinate2D(latitude: startY, longitude: startX)
        let endCoord = CLLocationCoordinate2D(latitude: endY, longitude: endX)

        print("✅ Kakao API에서 좌표 확보 → 경로 요청 시작")
        routeVM.fetchRoute(start: startCoord, end: endCoord, profile: .foot)
        selectedTab = 2
        searchingRoute = false
    }
    
}



#Preview {
    FindMapView(selectedTab: .constant(0))
}
