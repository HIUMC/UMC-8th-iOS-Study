import SwiftUI

struct OrderSheetView: View {
    @Bindable private var locationManager = LocationManager.shared
    @Bindable private var JSONParsingViewModel: JSONParsingViewModel = .init()
    @Bindable private var viewModel: MapViewModel = .init()

    @State private var isMapView = false
    @State private var selectedTab = 0
    @State private var isDataLoaded = false

    var body: some View {
        VStack(spacing: 0) {
            TopNavigationBarView(isMapView: $isMapView)
            
            SearchBarView()
            
            Spacer().frame(height: 5)
            
            StoreTabView(selectedTab: $selectedTab)
            Divider()
            
            Spacer()
            
            // 현재 위치 텍스트
            Text(viewModel.currentLocationText)
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.top, 8)

            // 📍 위치 다시 불러오기 버튼
            Button(action: {
                            viewModel.updateCurrentLocationText()
                            viewModel.loadAndFilterNearbyStores()
                        }) {
                            Text("📍 위치 다시 불러오기")
                                .font(.system(size: 14, weight: .medium))
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .cornerRadius(8)
                        }
                        .padding(.bottom, 8)
            
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.nearbyStores, id: \.self) { store in
                        StoreCardView(store: store)
                    }
                }
            }
            .task {
                if !isDataLoaded {
                    viewModel.updateCurrentLocationText()
                    viewModel.loadAndFilterNearbyStores()
                    isDataLoaded = true
                }
            }
        }
        .background(Color.white)
        .padding(.horizontal, 32)
    }
}


// MARK: - 매장 설정
struct TopNavigationBarView: View {
    @Binding var isMapView: Bool

    var body: some View {
        HStack {
            Spacer()
            Text("매장 설정")
                .font(.system(size: 16, weight: .semibold))
            Spacer()
            Button(action: {
                // 지도뷰로 연결되게
                isMapView.toggle()
            }) {
                Image(systemName: "map")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Color.white)
    }
}

// MARK: - 검색바
struct SearchBarView: View {
    var body: some View {
        HStack {
            Text("검색")
                .foregroundColor(.gray)
                .font(.system(size: 12))
            Spacer()
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(5)
    }
}

// MARK: - 가까운 매장 | 자주 가는 매장
struct StoreTabView: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {

            Button(action: {
                selectedTab = 0
            }) {
                Text("가까운 매장")
                    .font(.system(size: 13, weight: selectedTab == 0 ? .semibold : .regular))
                    .foregroundColor(selectedTab == 0 ? .black : .gray)
            }

            Text("  |  ")
                .foregroundColor(.gray)
                .font(.system(size: 13))

            Button(action: {
                selectedTab = 1
            }) {
                Text("자주 가는 매장")
                    .font(.system(size: 13, weight: selectedTab == 1 ? .semibold : .regular))
                    .foregroundColor(selectedTab == 1 ? .black : .gray)
            }

            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.systemGray5)),
            alignment: .bottom
        )
    }
}

// MARK: - 가게 리스트
struct StoreCardView: View {
    let store: StoreDisplayInfo

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "building.2")
                .resizable()
                .frame(width: 83, height: 83)

            VStack(alignment: .leading, spacing: 4) {
                Spacer().frame(height: 6)

                // 매장 이름
                Text(store.name)
                    .font(.customPretend(.medium, size: 13))
                    .foregroundColor(.black)

                // 도로명 주소
                Text(store.address)
                    .font(.customPretend(.regular, size: 10))
                    .foregroundColor(.gray)

                Spacer().frame(height: 15)
                HStack {
                    // R, D 태그
                    ForEach(store.tagSymbol, id: \.self) { tag in
                        Text(tag)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                            .background(
                                tag == "R" ? Color.customYellowColor :
                                    tag == "D" ? Color.mainGreenColor :
                                    Color.gray
                            )
                            .foregroundColor(.white)
                            .cornerRadius(4)
                    }

                    Spacer()

                    // 거리
                    Text(store.distance)
                        .font(.customPretend(.medium, size: 12))
                        .foregroundColor(.gray)
                }
            }

            Spacer()
        }
        .cornerRadius(6)
    }
}



#Preview {
    OrderSheetView()
}
