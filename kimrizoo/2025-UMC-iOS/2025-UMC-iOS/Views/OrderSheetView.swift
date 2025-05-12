import SwiftUI

struct OrderSheetView: View {
    
    @Bindable private var locationManager = LocationManager.shared
    @Bindable private var viewModel: MapViewModel = .init()
    
    @State private var isMapView = false
    @State private var selectedTab = 0
    let tabs = ["가까운 매장", "자주 가는 매장"]

    var body: some View {
        VStack(spacing: 0) {
            // MARK: 상단 네비게이션
            HStack {
                Spacer()
                Text("매장 설정")
                    .font(.system(size: 16, weight: .semibold))
                Spacer()
                Button(action: {
                    isMapView.toggle()
                }) {
                    Image(systemName: isMapView ? "list.bullet" : "map")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.customGray2)
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color.white)

            // MARK: 검색바
            HStack {
                Text("검색")
                    .foregroundColor(.gray)
                    .font(.system(size: 12))
                Spacer()
            }
            .padding(5)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding(.horizontal, 30)

            Spacer().frame(height: 5)
            
            // MARK: 탭 (가까운 매장 / 자주 가는 매장)
            HStack {
                Spacer().frame(width: 15)
                
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


            Divider()
        }
        .background(Color.white)
    }
}

#Preview
{
    OrderSheetView()
}
