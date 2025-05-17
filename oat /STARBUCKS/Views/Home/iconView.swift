//
//  ContentView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/27/25.
//
import Foundation
import SwiftUI

struct iconView: View {
    var body: some View {
            TabView{
                Tab("Home", image: "home") {
                    HomeView()
                }
                Tab("Pay", image: "pay") {
                    PayView()
                }
                Tab("Order", image: "Order") {
                    OrderView()
                }
                Tab("Shop", image:"shop") {
                    ShopView()
                }
                Tab("Other", image: "other") {
                    OtherView()
                }
            }
            .tint(Color("green02"))
            .onAppear {
                UITabBar.appearance().backgroundColor = .white
            }
        
    }
}
            

#Preview {
    iconView()
}
