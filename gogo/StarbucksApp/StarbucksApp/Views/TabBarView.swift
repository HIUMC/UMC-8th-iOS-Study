//
// TabView.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/7/25.
//




import SwiftUI
import Foundation

struct TabBarView: View {
    @EnvironmentObject var navigationRouter: NavigationRouter
    // NavigationRouter 주입
    
    init() {
        UITabBar.appearance().backgroundColor = .white
    }

    var body: some View {
        TabView {
            HomeView()
                .padding(.bottom,10) //이거 줘야 HomeView 안 잘려..
                .tabItem {
                    Label {
                        Text("Home")
                    } icon: {
                        Image("home")
                            .renderingMode(.template) //초록틴트적용
                    }
                    .border(.green)
                }

            PayView()
                .tabItem {
                    Label {
                        Text("Pay")
                    } icon: {
                        Image("pay")
                            .renderingMode(.template)
                    }
                }

            OrderView()
                .tabItem {
                    Label {
                        Text("Order")
                    } icon: {
                        Image("order")
                            .renderingMode(.template)
                    }
                }

            ShopView()
                .tabItem {
                    Label {
                        Text("Shop")
                    } icon: {
                        Image("shop")
                            .renderingMode(.template)
                    }
                }

            OtherView()
                .tabItem {
                    Label {
                        Text("Other")
                    } icon: {
                        Image("other")
                            .renderingMode(.template)
                    }
                }
        }
        .tint(Color(.green02)) // 탭 선택된 아이콘 색상
    }
}



struct TabBarView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            TabBarView()
                .environmentObject(NavigationRouter())
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
