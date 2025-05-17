//
//  TabView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct TabBarView: View {
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
        }
        .tint(.green02)
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
        }
        
    }
}

struct TabBarView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            TabBarView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
