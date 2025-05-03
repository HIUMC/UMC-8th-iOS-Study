//
//  Order.swift
//  Starbucks
//
//  Created by 김영택 on 3/29/25.
//

import SwiftUI

enum MenuTab{
    case all
    case mine
    case cake
}

struct OrderView: View {
    @Namespace private var animation
    @State private var selectedTheme: MenuTab = .all
    
    var body: some View {
        VStack {
            TopView
            Spacer().frame(height: 20)
            MiddleView
            Spacer().frame(height: 19)
            OrderCircleImage()
            BottomView()
        }
        .ignoresSafeArea(edges: .bottom)
        
    }
    
    private var TopView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Order")
                .font(.PretendardBold24)
                .padding(.leading, 23)
                .padding(.bottom, 19)
            
            
            HStack(spacing: 0) {
                ForEach([MenuTab.all, .mine, .cake], id: \.self) { tab in
                    Button(action: {
                        withAnimation(.easeInOut) {
                            selectedTheme = tab
                        }
                    }) {
                        VStack(spacing: 8) {
                            HStack(spacing: 4) {
                                if tab == .cake {
                                    Image(.cake)
                                        .renderingMode(.template)
                                }
                                Text(label(for: tab))
                                    .font(.PretendardSemibold16)
                            }
                            .foregroundColor(tab == .cake ? .green : color(for: tab))
                            
                            ZStack {
                                if selectedTheme == tab {
                                    Rectangle()
                                        .fill(Color.green)
                                        .frame(height: 3)
                                        .shadow(color: Color.black.opacity(0.2), radius: 1, y: 1)
                                        .matchedGeometryEffect(id: "underline", in: animation)
                                } else {
                                    Color.clear.frame(height: 3)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.trailing, 33)
            
            Divider() // 회색 경계선
                .background(Color.black.opacity(0.15)) // 선 색 조정
        }
    }
    
    
    
    
    private func label(for tab: MenuTab) -> String {
        switch tab {
        case .all: return "전체 메뉴"
        case .mine: return "나만의 메뉴"
        case .cake: return "홀케이크 예약"
        }
    }
    
    private func color(for tab: MenuTab) -> Color {
        if selectedTheme == tab {
            return .black
        } else {
            return .gray
        }
    }
    
    
    private var MiddleView: some View {
        Group {
            switch selectedTheme {
            case .all:
                AllMenuView()
            case .mine:
                MyMenuView()
            case .cake:
                CakeMenuView()
            }
        }
    }
    
    
    struct AllMenuView: View {
        enum MenuType: String {
            case menu = "음료"
            case food = "푸드"
            case product = "상품"
        }
        
        @State private var selectedMenu: MenuType = .menu
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    menuButton(.menu)
                    menuButton(.food)
                    menuButton(.product)
                }
                .padding(.leading, 23)
                
                Divider()
                    .background(Color.black.opacity(0.15))
            }
        }
        
        
        @ViewBuilder
        private func menuButton(_ type: MenuType) -> some View {
            Button(action: {
                selectedMenu = type
            }) {
                HStack {
                    Text(type.rawValue)
                        .foregroundColor(selectedMenu == type ? .black : .gray)
                    Image("new")
                }
            }
        }
    }
    
    
    struct MyMenuView: View {
        var body: some View {
            Text("")
        }
    }
    
    struct CakeMenuView: View {
        var body: some View {
            Text("")
        }
    }
}

struct BottomView: View {
    @State private var showSheet = false

    var body: some View {
        ZStack(alignment: .bottom) {
           
            BottomFixedView {
                showSheet = true
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .sheet(isPresented: $showSheet) {
            StoreSelectionSheet(viewModel: JSONParsingViewModel())
                .presentationDetents([.medium, .large])
        }
    }
}

struct BottomFixedView: View {
    var onTap: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                onTap()
            }) {
                HStack {
                    Text("주문할 매장을 선택해 주세요")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))

                    Spacer()

                    Image(systemName: "chevron.down")
                        .foregroundColor(.white)
                        .imageScale(.medium)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
            }
            

            Rectangle()
                .fill(Color.black.opacity(0.5))
                .frame(height: 1)
        }
        .background(Color(.darkGray))
    }
}

struct StoreSelectionSheet: View {
    @State private var searchText = ""
    @State private var selectedTab: StoreTab = .nearby
    @State private var showMapView = false
    @ObservedObject var viewModel: JSONParsingViewModel

    
    enum StoreTab {
        case nearby, frequent
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Text("매장 설정")
                    .font(.PretendardSemibold16)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack {
                    Spacer()
                    Button(action: {
                        showMapView.toggle()
                    }) {
                        Image(.map)
                    }

                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 24)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("검색", text: $searchText)
                    .foregroundColor(.primary)
                    .font(.PretendardSemibold14)
            }
            .padding(3)
            .background(Color(.systemGray6))
            .cornerRadius(5)
            .padding(.horizontal, 25)
            Spacer().frame(height: 18)
            
            HStack(spacing: 12) {
                Button(action: {
                    selectedTab = .nearby
                }) {
                    Text("가까운 매장")
                        .foregroundColor(selectedTab == .nearby ? .black : .gray)
                        .font(.PretendardSemibold13)
                }
                Image(.vector)
                    .resizable()
                    .frame(width: 1, height: 12)
                    
                Button(action: {
                    selectedTab = .frequent
                }) {
                    Text("자주가는 매장")
                        .font(.PretendardSemibold14)
                        .foregroundColor(selectedTab == .frequent ? .black : .gray)
                }
            }
            .padding(.horizontal, 30)
            Spacer().frame(height: 18)
            
            Divider()
                .background(Color.black.opacity(0.15))
                .padding(.horizontal, 30)
            
            Spacer()
            
            if showMapView {
                MapView(viewModel: JSONParsingViewModel())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.opacity)
            } else {
                JSONParsingView()
                    .transition(.opacity)
            }

        }
        
    }
}


#Preview {
    OrderView()
}
