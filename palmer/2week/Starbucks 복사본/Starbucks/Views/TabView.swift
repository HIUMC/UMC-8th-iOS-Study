//
//  TabView.swift
//  Starbucks
//
//  Created by 박정환 on 3/31/25.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        TabView {
            Tab("Home", image: "Home") {
                HomeView()
            }
            Tab("Pay", image: "Pay") {
                PayView()
            }
            Tab("Order", image: "Order") {
                OrderView()
            }
            Tab("Shop", image: "Shop") {
                ShopView()
            }
            Tab("Other", image: "Other") {
                OtherView()
            }
        }
        .tint(Color("green01"))
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

#Preview {
    TabView()
}
