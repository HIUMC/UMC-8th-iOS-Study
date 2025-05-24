import SwiftUI
import CoreLocation

struct OrderSheetView: View {
    @State private var isMapMode = false
    @State private var selectedTab: Tab = .nearby
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel = OrderSheetViewModel()

    enum Tab {
        case nearby
        case frequent
    }

    var body: some View {
        VStack(spacing: 0) {
            TopView
            segmentView
            Divider()

            if isMapMode {
                OrderMapView()
            } else {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        ForEach(viewModel.stores) { store in
                            StoreRow(store: store)
                                .padding(.horizontal, 20)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadGeoJson { result in
                switch result {
                case .success:
                    if let location = locationManager.currentLocation {
                        viewModel.updateDistances(from: location)
                    }
                case .failure(let error):
                    print("GeoJSON 에러: \(error)")
                }
            }
        }
        .onReceive(locationManager.$currentLocation) { location in
            if let location = location {
                viewModel.updateDistances(from: location)
            }
        }
        .presentationDragIndicator(.visible)
    }

    private var TopView: some View {
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    Spacer()
                    Text("매장 설정")
                        .font(.custom("Pretendard-Medium", size: 16))
                        .padding(.top, 24)
                        .padding(.bottom, 24)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Button(action: {
                        isMapMode.toggle()
                    }) {
                        Image(isMapMode ? "list" : "map")
                            .resizable()
                            .frame(width: 18, height: 17)
                    }
                    .padding(.trailing, 33)
                }
            }

            Text("검색")
                .font(.custom("Pretendard-SemiBold", size: 12))
                .foregroundColor(.gray)
                .padding(.horizontal, 12)
                .frame(height: 36)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.08))
                )
                .padding(.horizontal, 20)
        }
    }

    private var segmentView: some View {
        HStack(spacing: 8) {
            Button(action: {
                selectedTab = .nearby
            }) {
                Text("가까운 매장")
                    .font(.custom("Pretendard-Bold", size: 13))
                    .foregroundColor(selectedTab == .nearby ? .black : .gray)
            }

            Text("|")
                .foregroundColor(.gray)

            Button(action: {
                selectedTab = .frequent
            }) {
                Text("자주 가는 매장")
                    .font(.custom("Pretendard-Bold", size: 13))
                    .foregroundColor(selectedTab == .frequent ? .black : .gray)
            }

            Spacer()
        }
        .padding(.top, 22)
        .padding(.horizontal, 20)
        .padding(.bottom, 17)
    }
}

// 위치 관리자


#Preview {
    OrderSheetView()
}
