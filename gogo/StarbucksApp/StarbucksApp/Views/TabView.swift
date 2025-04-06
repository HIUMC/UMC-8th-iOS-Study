//
// TabView.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/7/25.
//




import SwiftUI
import Foundation

struct TabBarView: View {
    init() {
        UITabBar.appearance().backgroundColor = .white
    }

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label {
                        Text("Home")
                    } icon: {
                        Image("home")
                            .renderingMode(.template) // 중요!!
                    }
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
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
