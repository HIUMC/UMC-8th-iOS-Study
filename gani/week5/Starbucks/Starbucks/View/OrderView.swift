//  OrderView.swift
//  Starbucks
//
//  Created by 이가원 on 5/22/25.
//

import SwiftUI

struct OrderView: View {
    @StateObject var viewModel = OrderMenuViewModel()
    @State private var showSheet = false

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    
                    TopView
                    SelectView()
                    Select2View()
                    Spacer().frame(height: 19)
                    MenuView(menus: viewModel.ordermenu)
                        .padding(.bottom, 100)
                    
                }
            }

            
            Button(action: {
                showSheet = true
            }) {
                HStack {
                    Text("주문할 매장을 선택해 주세요")
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.black02)
            }
            .padding(.horizontal, 16)
            .sheet(isPresented: $showSheet) {
                OrderSheetView()
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}

    private var TopView: some View {
        VStack(alignment: .leading) {
            Text("Order")
                .font(.custom("Pretendard-Bold", size: 24))
                .padding(6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 23)
    }

struct SelectView: View {
    @State private var selectedTab: Tab? = nil

    enum Tab {
        case allMenu, myMenu
    }

    var body: some View {
        HStack(spacing: 0) {
            SelectTabItem(
                title: "전체 메뉴",
                isSelected: selectedTab == .allMenu,
                alwaysGreen: false,
                imageName: nil
            ) {
                selectedTab = .allMenu
            }
            .frame(width: 119, height: 50)

            SelectTabItem(
                title: "나만의 메뉴",
                isSelected: selectedTab == .myMenu,
                alwaysGreen: false,
                imageName: nil
            ) {
                selectedTab = .myMenu
            }
            .frame(width: 119, height: 50)

            Spacer()

            CakeTabItem()
        }
        .padding(.horizontal, 23)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: 3)
    }
}

struct SelectTabItem: View {
    let title: String
    let isSelected: Bool
    let alwaysGreen: Bool
    let imageName: String?
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 0) {
                HStack(spacing: 4) {
                    if let imageName = imageName {
                        Image(imageName)
                            .resizable()
                            .frame(width: 16, height: 16)
                    }

                    Text(title)
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .foregroundColor(
                            alwaysGreen ? .green1 : (isSelected ? .black : .gray)
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)

                Rectangle()
                    .fill(isSelected ? Color.green1 : Color.clear)
                    .frame(height: 3)
            }
        }
    }
}

struct CakeTabItem: View {
    var body: some View {
        HStack(spacing: 4) {
            Image("cake")
                .resizable()
                .frame(width: 16, height: 16)

            Text("홀케이크 예약")
                .font(.custom("Pretendard-SemiBold", size: 16))
                .foregroundColor(.green1)
        }
        .frame(height: 50)
        .padding(.trailing, 27)
    }
}

struct Select2View: View {
    @State private var selectedTab: Tab = .drink

    enum Tab: String, CaseIterable {
        case drink = "음료"
        case food = "푸드"
        case product = "상품"
    }

    var body: some View {
        HStack(spacing: 32) {
            ForEach(Tab.allCases, id: \.self) { tab in
                TabItemView(
                    title: tab.rawValue,
                    isSelected: selectedTab == tab,
                    onTap: {
                        selectedTab = tab
                    }
                )
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 23)
        .padding(.top, 12)
        .padding(.bottom, 8)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.10), radius: 0, x: 0, y: 1)
    }
}

struct TabItemView: View {
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    Text(title)
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .foregroundColor(isSelected ? .black : .gray)
                    Image("newnew")
                        .resizable()
                        .frame(width: 16, height: 10)
                }
            }
        }
    }
}

struct MenuView: View {
    let menus: [OrderMenu]

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 26) {
            ForEach(menus) { item in
                HStack(alignment: .center, spacing: 16) {
                    Image(item.imageName)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        HStack(spacing: 1) {
                            Text(item.nameKo)
                                .font(.custom("Pretendard-SemiBold", size: 16))
                                .foregroundStyle(.gray6)
                            if item.isNew {
                                Circle()
                                    .fill(Color.green1)
                                    .frame(width: 1, height: 1)
                            }
                        }
                        Text(item.nameEn)
                            .font(.custom("Pretendard-SemiBold", size: 13))
                            .foregroundStyle(.gray3)
                    }
                }
                .padding(.leading, 23)
            }
        }
    }
}

#Preview {
    OrderView()
}
