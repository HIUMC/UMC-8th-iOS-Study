//
//  SwiftUIView.swift
//  Starbucks
//

//

import SwiftUI
import Foundation

struct TabBarView: View {
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        TabView {
            Tab("Home", image: "home") {
                HomeView()
            }
            Tab("Pay", image: "pay") {
                PayView()
            }
            Tab("Order", image: "order") {
                OrderView()
            }
            Tab("Shop", image: "shop") {
                ShopView()
            }
            Tab("Other", image: "other") {
                OtherView()
            }
        }.tint(Color(.green02))
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
