//
//  TabView.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/30/25.
//

import SwiftUI
import Foundation

struct MyTabView: View {
    var body: some View {
        TabView {
            Tab("Home", image: "home"){
                HomeView()
            }
            Tab("Pay", image: "pay"){
                PayView()
            }
            Tab("Order", image: "order"){
                OrderView()
            }
            Tab("Shop", image: "shop"){
                ShopView()
            }
            Tab("Other", image: "other"){
                OtherView()
            }
            
        }
        .tint(Color("green02"))
    }
    
}


#Preview {
    MyTabView()
}
