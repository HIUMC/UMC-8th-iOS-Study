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
                HomeView()
                    .tabItem{
                        Image("Home")
                    }
                
                PayView()
                    .tabItem{
                        Image("Pay")
                    }
                
                OrderView()
                    .tabItem{
                        Image("Order")
                    }
                
                ShopView()
                    .tabItem{
                        Image("Shop")
                    }
                
                OtherView()
                    .tabItem{
                        Image("Other")
                    }
                
            }.tint(Color.green02)
            .onAppear {
                UITabBar.appearance().backgroundColor = .white
            }
        }
    }


#Preview {
    TabBarView()
}

