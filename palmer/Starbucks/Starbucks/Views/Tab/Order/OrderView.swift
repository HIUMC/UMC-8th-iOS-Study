//
//  OrderView.swift
//  Starbucks
//
//  Created by 박정환 on 3/31/25.
//
import SwiftUI

struct OrderView: View {
    @Binding var currentTabOrder: Int
    @Binding var currentTabAll: Int
    
    @State private var viewModel: OrderViewModel = .init()
    
    @State var showSheet: Bool = false
    @State private var JSONViewModel: JSONParsingViewModel = .init()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Order")
                .padding(.top, 20)
                .padding(.leading, 24)
                .foregroundStyle(Color("black03"))
                .font(.mainTextBold24)

            orderTabBar
            
            if currentTabOrder == 0 {
                allTabBar
                Divider()
                if currentTabAll == 0 {
                    coffees
                } else if currentTabAll == 1 {
                    Text("desserts")
                    Spacer()
                } else {
                    Text("상품")
                    Spacer()
                }
            } else if currentTabOrder == 1 {
                Text("나만의 메뉴")
                Spacer()
            } else {
                Text("홀케이크 예약")
                Spacer()
            }
            selectStore
        }
    }
    
    private var orderTabBar: some View {
        ZStack {
            Rectangle()
                .fill(Color("white00"))
                .shadow(color: .black.opacity(0.15), radius: 1.5, x: 0, y: 3)
            
            HStack {
                ForEach(OrderTabOptions.allCases, id:\.self) { menu in
                    Button(action: {
                        currentTabOrder = menu.id
                    }, label: {
                        VStack {
                            HStack(spacing: 2) {
                                if menu.id == 2 {
                                    Image(.cake)
                                }
                                
                                Text(menu.title)
                                    .foregroundStyle(menu.id == 2 ? Color("green01") : currentTabOrder == menu.id ? Color("black01") : Color("gray04"))
                                    .font(.mainTextSemiBold16)
                            }
//                            .padding(.vertical, 12)
                            .frame(height: 40)
                            
                            Rectangle()
                                .fill(currentTabOrder == menu.id ? Color("green01") : .clear)
                                .frame(height: 3)
                        }
                    })
                }
            }
        }
        .frame(height: 52)
    }
    
    private var allTabBar: some View {
        HStack {
            ForEach(
                AllTabOptions.allCases, id:\.self) { menu in
                Button(action: {
                    currentTabAll = menu.id
                }, label: {
                    HStack(alignment: .top) {
                        Text(menu.title)
                            .foregroundStyle(currentTabAll == menu.id ? Color("black01") : Color("gray04"))
                            .font(.mainTextSemiBold16)
                        
                        Image(.new)
                    }
                })
            }
        }
        .padding(.leading, 24)
        .padding(.vertical, 18)
        .frame(height: 52)
    }
    
    private var coffees: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                ForEach(Array(viewModel.coffees.enumerated()), id: \.element.id) { index, coffee in
                    coffeeCard(img: coffee.img, name: coffee.name, nameEng: coffee.nameEng)
                        .padding(.top, index == 0 ? 20 : 0)
                        .padding(.bottom, index == viewModel.coffees.count - 1 ? 24 : 0)
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 20)
    }
    
    private func coffeeCard(img: String, name: String, nameEng: String) -> some View {
        HStack(spacing: 16) {
            Image(img)
                .resizable()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                HStack(alignment: .top, spacing: 2) {
                    Text(name)
                        .foregroundStyle(Color("gray06"))
                        .font(.mainTextSemiBold16)
                    
                    Circle()
                        .fill(Color("green01"))
                        .frame(width: 6, height: 6)
                }
                
                Text(nameEng)
                    .foregroundStyle(Color("gray03"))
                    .font(.mainTextSemiBold13)
            }
        }
    }
    
    private var selectStore: some View {
        Button(action: {
            self.showSheet.toggle()
        }, label: {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("주문할 매장을 선택해 주세요")
                        .foregroundStyle(Color("white00"))
                        .font(.mainTextSemiBold16)

                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundStyle(Color("white00"))
                }
                Rectangle()
                    .fill(Color("gray06"))
                    .frame(height: 1)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .frame(height: 60)
            .background(Color("black02"))
        })
        .sheet(isPresented: $showSheet, content: {
            OrderSheetView(viewModel: JSONViewModel)
        })
    }
}

#Preview {
    @Previewable @State var selectedOrderTabIndex: Int = 0
    @Previewable @State var selectedAllTabIndex: Int = 0
    
    OrderView(currentTabOrder:  $selectedOrderTabIndex, currentTabAll: $selectedAllTabIndex)
}
