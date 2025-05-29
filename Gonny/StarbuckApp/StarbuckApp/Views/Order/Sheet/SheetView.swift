//
//  OrderSheetView.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/29/25.
//
//매장리스트+지도를 나타내는 뷰,,맵뷰랑 리스트뷰 다들 따로 빼서 구현했나?
import SwiftUI
import CoreLocation

enum StoreTab: String, CaseIterable {
    case nearby = "가까운 매장"
    case favorites = "자주 가는 매장"
}

struct OrderSheetView: View {
    // MARK: - Properties
    @State private var isMapShown = false
    @State private var searchText = ""
    @State private var selectedTab: StoreTab = .nearby
    @StateObject var viewModel: OrderSheetViewModel = .init()
    @StateObject var locationManager: LocationManager = .shared
    @ObservedObject var mapViewModel: MapViewModel = .init()
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: - 상단 네비게이션
            headerView
            
            // MARK: - 검색 바
            searchBarView
            
            // MARK: - 세그먼트 탭
            segmentTabView
            
            Divider()
            
            // MARK: - 리스트 or 지도 뷰 전환
            if isMapShown {
                StoreMapView(viewModel: mapViewModel, locationManager: locationManager)
            } else {
                ScrollView {
                    StoreListView(stores: viewModel.stores)
                }
                .task {
                    print("task 실행됨")
                    if let loc = locationManager.userLocation {
                        viewModel.loadNearbyStores(
                            userLocation: CLLocation(latitude: loc.latitude, longitude: loc.longitude)
                        )
                    }
                }
            }
        }
    }
        
    
        // MARK: - View Component
    private var headerView: some View {
        ZStack {
            Text("매장 설정")
                .font(.mainTextMedium16)
                .foregroundColor(Color("black03"))
            
            HStack {
                Spacer()
                Button(action: {
                    isMapShown.toggle()
                }) {
                    Image(isMapShown ? "listVector" : "mapVector")
                        .resizable()
                        .frame(width: 18, height: 18)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
        
        private var searchBarView: some View {
            TextField("검색", text: $searchText)
                .font(.mainTextSemiBold13)
                .foregroundColor(Color("gray06"))
                .padding(10)
                .background(Color("gray08"))
                .cornerRadius(8)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
        }
    
        
        private var segmentTabView: some View {
            HStack(spacing: 16) {
                Button(action: {
                    selectedTab = .nearby
                    if let userLoc = locationManager.currentLocation {
                            viewModel.loadNearbyStores(userLocation: userLoc)
                        }
                }) {
                    Text("가까운 매장")
                        .font(.mainTextSemiBold13)
                        .foregroundColor(selectedTab == .nearby ? Color("black03") : Color("gray03"))
                }
                
                Text("|")
                    .foregroundColor(Color("gray03"))
                
                Button(action: {
                    selectedTab = .favorites
                }) {
                    Text("자주 가는 매장")
                        .font(.mainTextSemiBold13)
                        .foregroundColor(selectedTab == .favorites ? Color("black03") : Color("gray03"))
                }
                .disabled(true)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
        }
    }


//프리뷰
struct OrderSheetView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSheetView(viewModel: OrderSheetViewModel())
            .environmentObject(LocationManager.shared) // 환경 객체 명시
    }
}

