//
//  TabView.swift
//  Starbucks
//
//  Created by 김영택 on 3/29/25.
//

import SwiftUI

struct BottomTabView: View {
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
                    .environment(NavigationRouter())
                    .environment(MapListViewModel())
            }
            
            Tab("Shop", image: "shop") {
                ShopView()
            }
            
            Tab("Other", image: "other") {
                OtherView()
            }
        }//TabView End
        .tint(.tabgreen)
    }
}
    
#Preview {
    BottomTabView()
}

