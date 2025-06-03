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
        //.sheet(isPresented: $showPopup) {OrderSheetView()}
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
        .sheet(isPresented: $showSheet){
            OrderSheetView()
        }
        }
            
           
}
#Preview {
    OrderView()
}
