//
//  TapView.swift
//  Starbucks
//
//  Created by 이가원 on 3/29/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Home", image: "grayhome") {
                HomeView()
            }
            
            Tab("Pay", image: "realcard") {
                
            }
            
            Tab("Order", image: "coffee") {
                
            }
            
            Tab("Shop", image: "bag") {
                ShopView()
            }
            
            Tab("Other", image: "etc") {
                OtherView()
            }
        }
        .tint(Color(.greeen2))
    }
}
#Preview {
    MainTabView()
}
