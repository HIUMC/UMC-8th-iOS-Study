//
//  TabView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/27/25.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        
    TabView {
            
            Tab("", image: "Home") {
                HomeView()
            }
            
            
            Tab("", image: "Pay") {
                PayView()
            }
            
            Tab("", image: "Order") {
                OrderView()
            }
            
            Tab("", image: "Shop") {
                ShopView()
            }
            
            Tab("", image: "Other") {
                OtherView()
            }
    }.tint(Color.green02)
    }
}


#Preview {
    TabBarView()
}
