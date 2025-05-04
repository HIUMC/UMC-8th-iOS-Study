//
//  OrderView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/2/25.
//

import SwiftUI

struct OrderView: View {
    @State var currentTab: TabOrderItem = .allMenu
    @Namespace var namespace
    
    var body: some View {
        VStack {
            TopOrderView()
            TabOrderView(currentTab: $currentTab, namespace: _namespace)
            SelectCategoryBar()
            OrderCoffeeView()
            SelectUnderBar()
            }
            
        
    }
    
    private func TopOrderView() -> some View {
        HStack {
            Text("Order")
                .font(.PretendardBold24)
                .foregroundStyle(Color.black03)
                .padding(.horizontal, 23)
            Spacer()
        }
        .padding(.top, 19)
        .padding(.bottom, 6)
    }
    
}



struct TabOrderView: View {
    @Binding var currentTab: TabOrderItem
    @Namespace var namespace

    var body: some View {
        ZStack(alignment: .center) {
            Rectangle()
                .fill(Color.white)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .shadow(color: Color.gray.opacity(0.3) ,radius: 4, x:0, y:5)
                .padding(.bottom, 10)
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 70) {
                        ForEach(TabOrderItem.allCases) { item in
                            TabBarItem(currentTab: $currentTab,
                                       namespace: namespace,
                                       tabItem: item)
                        }
                    }
                    .padding(.horizontal)
                }
                
                
            }
            //.background(Color.white)
            .frame(height: 40)
        }
    }
}

// MARK: - Subviews

struct TabBarItem: View {
    @Binding var currentTab: TabOrderItem
    let namespace: Namespace.ID
    let tabItem: TabOrderItem
    
    var body: some View {
            Button {
                withAnimation(.spring()) {
                    currentTab = tabItem
                }
            } label: {
                
                VStack(spacing: 0) {
                    HStack(spacing: 3) {
                        if tabItem == .cakeReserve {
                            Image("cakeIcon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16)
                        }
                        Text(tabItem.title)
                            .lineLimit(1)
                            .layoutPriority(1)
                    }
                    .foregroundColor(currentTab == tabItem ? .black : .gray)
                    .font(.PretendardBold16)
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(height: 45, alignment: .center)
                    
                    if currentTab == tabItem {
                        Rectangle()
                            .fill(Color.green)
                            .frame(height: 8)
                            .matchedGeometryEffect(id: "underline", in: namespace)
                    } else {
                        Color.clear.frame(height: 8) //언더바만큼의 높이 넣어주기
                    }
                }
                
            }
            .frame(height: 44)
            .buttonStyle(.plain)
    }
}

// MARK: - Subviews

struct SelectCategoryBar: View {
    enum OrderCategory: String, CaseIterable {
        case drink = "음료"
        case food = "푸드"
        case product = "상품"
    }
    @State private var selectedCategory: OrderCategory = .drink
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 15) {
                ForEach(OrderCategory.allCases, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        HStack(spacing: 4) {
                            Text(category.rawValue)
                                .font(.PretendardSemiBold16)
                                .foregroundStyle(selectedCategory == category ? .black : .gray)
                            
                            if category == .drink || category == .food || category == .product {
                                Image("new")
                                    .resizable()
                                    .frame(width: 18, height: 8)
                                    .offset(y: -6)
                            }
                        }
                    }
                }
            }
            .padding(.top, 13)
            .padding(.horizontal, 23)
            
            Divider()
                .padding(.top, 15)
                .padding(.horizontal)
            
        }//H
    }
}
    
// MARK: - Subviews

    
struct SelectUnderBar: View {
    @State var showSheet: Bool = false
    var viewModel: JSONParsingViewModel = .init()
    //@State var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black02)
                .frame(width: 440, height: 80)
            VStack {
                Button(action: {showSheet.toggle()}) {
                    VStack {
                        HStack {
                            
                            Text("주문할 매장을 선택해 주세요")
                                .foregroundStyle(Color.white)
                                .font(.PretendardSemiBold16)
                            Spacer()
                            Image("downIcon")
                        } // h
                        .padding(.horizontal, 20)
                        
                        Rectangle()
                            .frame(width: 400, height: 1)
                            .foregroundStyle(Color.gray66)
                    }
                }
                .frame(width: 440, height: 80) // 정해주기
            }
            .sheet(isPresented: $showSheet) {
                //Text("여기에 매장 선택 Sheet 뷰 넣기")
                VStack {
                        SheetView()
                    }
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
                
            }
            
            
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

    
    
    #Preview {
        PreviewWrapper()
    }
    
    private struct PreviewWrapper: View {
        @State private var currentTab: TabOrderItem = .allMenu
        @Namespace private var namespace
        
        var body: some View {
            OrderView()
            //TabOrderView(currentTab: $currentTab, namespace: _namespace)
        }
    }

