//
//  OrderView.swift
//  Starbucks_Week1_gogo
//
//  Created by 고석현 on 4/1/25.
//

import SwiftUI

struct OrderView: View {
    @State private var viewModel = OrderViewModel()
    @State private var showStoreSheet = false
    @Namespace private var animation

    var body: some View {
        VStack(spacing: 0) {
            topTabView
                .padding(.top, 10)
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 5)
            
            bottom
                .padding(.top, 10)
            
            Divider()
            
            coffeeListView
                .padding(.top, 10)
            
            selectStoreButton
                .padding(.horizontal)
                .padding(.bottom, 10)
        }
        .sheet(isPresented: $showStoreSheet) {
            Text("매장 선택 화면")
                .font(.largeTitle)
        }
        .navigationTitle("Order")
        .navigationBarTitleDisplayMode(.inline)
    }
}

extension OrderView {
    
    // MARK: - Top Tab View
    private var topTabView: some View {
        HStack(spacing: 0) {
            ForEach(TopTab.allCases, id: \.self) { tab in
                Button(action: {
                    withAnimation {
                        viewModel.selectedTopTab = tab
                    }
                }) {
                    VStack(spacing: 4) {
                        if tab == .cakeReservation {
                            HStack(spacing: 4) {
                                Image("cake")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                Text(tab.rawValue)
                                    .font(.PretendardSemiBold18)
                                    .foregroundStyle(.green00)
                              
                            }
                        } else {
                            Text(tab.rawValue)
                                .font(.PretendardSemiBold18)
                                .foregroundStyle(.black01)
                        }
                        
                        if viewModel.selectedTopTab == tab {
                            Capsule()
                                .fill(Color.green)
                                .frame(height: 3)
                                .matchedGeometryEffect(id: "topTab", in: animation)
                        } else {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 3)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 6)
    }
    
    // MARK: - Bottom Tab View
    // 하단 탭
    private var bottom: some View {
        HStack(spacing: 16) { // 버튼들 간 간격
            ForEach(BottomTab.allCases, id: \.self) { tab in
                Button(action: {
                    withAnimation {
                        viewModel.selectedBottomTab = tab
                    }
                }) {
                    HStack(spacing: 4) { // 텍스트와 이미지 간 간격
                        Text(tab.rawValue)
                            
                            .foregroundColor(viewModel.selectedBottomTab == tab ? .green01 : .gray)
                            .font(.system(size: 16, weight: viewModel.selectedBottomTab == tab ? .bold : .regular))
                            .multilineTextAlignment(.leading)
                            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                            .frame(alignment: .leading)
                        
                        Image("new") //
                            .resizable()
                            .frame(width: 22, height:22)
                            .offset(x: 0, y: -6) // 텍스트 오른쪽 위에 위치
                        
                    }
                }
            }
        }
        .padding(.vertical, 10)
    }
    
    // MARK: - Coffee List View
    private var coffeeListView: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.orderList) { item in
                    HStack(spacing: 15) {
                        Image(item.imageName)
                            .resizable()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.name)
                                .font(.PretendardSemiBold13)
                            Text(item.subTitle)
                                .font(.PretendardSemiBold13)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    // MARK: - Store Select Button
    private var selectStoreButton: some View {
        Button(action: {
            showStoreSheet.toggle()
        }) {
            Text("주문할 매장을 선택해주세요")
                .foregroundColor(.white)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
        }
    }
}


#Preview {
    OrderView()
}
