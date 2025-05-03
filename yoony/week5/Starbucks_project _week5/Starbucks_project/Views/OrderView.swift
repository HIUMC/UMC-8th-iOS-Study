//
//  OrderView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/27/25.
//

import SwiftUI
import CoreLocation

enum MenuTopTab: String, CaseIterable {
    case all = "전체 메뉴"
    case my = "나만의 메뉴"
    case cake = "홀케이크 예약"

}

enum MenuBottomTap: String, CaseIterable {
    case drinks = "음료"
    case food = "푸드"
    case products = "상품"
}

enum StoreTab: String, CaseIterable {
    case nearby = "가까운 매장"
    case frequent = "자주 가는 매장"
}

struct OrderView: View {
    @State var selectedTab: MenuTopTab = .all
    @State var selectedBottomTab: MenuBottomTap = .drinks
    @State private var showSheet = false
    @State private var selectedStoreTab: StoreTab = .nearby
    @State private var isMapView = false

    
    @Namespace private var topUnderlineNamespace
    
    @ObservedObject var viewModel: StoreViewModel

    init(viewModel: StoreViewModel = StoreViewModel()) {
        self.viewModel = viewModel
    }

    @State private var viewModel2 = CoffeMenuListViewModel()

    var body: some View {
        VStack (spacing: 27) {
            
            Text("Order")
                .font(.mainTextBold24)
                .foregroundStyle(.black03)
                .frame(maxWidth: .infinity, alignment: .leading)  // 왼쪽 정렬
                .padding(.leading, 23)
                
            TopSegmentView
            
            BottomSegmentView
            
            Divider()
            
            
            CoffeeMenuView
                .padding(.top, -27)
            
            SelectStoreView
        }
        .onAppear {
                    viewModel.loadStores()  // 화면이 나타날 때 매장 데이터 로딩
                }
        .background(Color.white)  // 배경색을 흰색으로 설정
            

        
    }
    
    var TopSegmentView: some View {
        HStack{
            ForEach(MenuTopTab.allCases, id: \.self) { tab in Button(action: { selectedTab = tab} ) {
                VStack {
                    Text(tab.rawValue)
                        .foregroundStyle(selectedTab == tab ? .black01 : .grey04)
                    
                    if selectedTab == tab {
                        
                        Capsule()
                            .fill(Color.green02)
                            .frame(height: 3)
                            .matchedGeometryEffect(id: "underline", in: topUnderlineNamespace)
                            .shadow(color: .green.opacity(0.5), radius: 4, y:2)
                        
                    } else {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 3)
                        
                    }
                    
                }
            }
            .frame(maxWidth: .infinity)
            }
        }
    }
    
    var BottomSegmentView: some View {
        HStack (spacing: 13) {
            ForEach(MenuBottomTap.allCases, id: \.self) { tab in Button(action: {self.selectedBottomTab = tab}){
                
                Text(tab.rawValue)
                    .foregroundStyle(selectedBottomTab == tab ? .black01 : .grey04)
                    .font(.mainTextSemiBold16)
                    .lineLimit(1)
                
                Image("new")
                    .resizable()
                    .frame(width: 14, height: 6.5)
                    .padding(.trailing, 6)
            }
                
            }
            Spacer()
        }
        .padding(.leading, 23)
    }
    
    var CoffeeMenuView: some View {
        ScrollView{
            LazyVStack(spacing: -9){
                ForEach(viewModel2.Coffees, id: \.id) { coffee in
                    ListCard(model: coffee)
                }
            }
        }
    }
    var SelectStoreView: some View {
        Button(action: {showSheet.toggle()}) {
            Image("selectplace")
        }
        .sheet(isPresented: $showSheet, content: {
            VStack{
                HStack{
                    Spacer()
                    
                    Text("매장 설정")
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    
                    Image("map")
                        .padding(.trailing, 40)
                }
                ZStack(alignment: .leading){
                    Image("search")
                    Text("검색")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.grey00)
                        .padding(.leading, 7)
                }
                
                HStack {
                    ForEach(StoreTab.allCases, id: \.self) { tab in
                        Button(action: {
                            selectedStoreTab = tab
                        }) {
                            Text(tab.rawValue)
                                .font(.system(size: 16, weight: .semibold))
                                .padding()
                                .foregroundColor(selectedStoreTab == tab ? .black03: .grey03)
                            
                        }
                    }
                }
                
                if selectedStoreTab == .nearby {
                    List(viewModel.stores) { store in
                                            StoreCellView(store: store, distance: viewModel.distanceFromCurrentLocation(store: store))
                                                .padding(.bottom, 10)
                                        }
                                        .onAppear {
                                            viewModel.loadStores()  // 뷰가 나타날 때 매장 데이터 로드
                                        }
                            }
                        }
            .onAppear {
                viewModel.loadStores()
            }
                    })
                }

            }
    

struct StoreCellView: View {
    var store: StoreFeature
    var distance: Double  // 현재 위치에서의 거리
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(store.properties.storeName)
                    .font(.headline)
                    .foregroundColor(.black)
                Text(store.properties.address)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    if store.properties.category == "리저브" {
                        TagLabel(text: "R", color: .green)
                    } else if store.properties.category == "DT" {
                        TagLabel(text: "D", color: .blue)
                    }
                    Text(String(format: "%.2f km", distance))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 5)
    }
}

struct TagLabel: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.caption2)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding(.horizontal, 5)
            .padding(.vertical, 2)
            .background(color)
            .cornerRadius(4)
    }
}


#Preview {
    let viewModel = StoreViewModel()
    viewModel.stores = [
        StoreFeature(
            type: "Feature",
            properties: StoreProperties(
                storeName: "신림사거리점",
                address: "서울 관악구 신림로",
                telephone: "02-1234-5678",
                category: "리저브",
                xcoordinate: 126.941,
                ycoordinate: 37.483,
                type: "카페"
            ),
            geometry: StoreGeometry(
                type: "Point",
                coordinates: [126.941, 37.483]
            )
        )
    ]

    return OrderView(viewModel: viewModel)
}
