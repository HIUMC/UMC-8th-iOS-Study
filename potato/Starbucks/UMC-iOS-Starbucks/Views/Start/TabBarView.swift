//
//  TabBar.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

struct TabBarView: View {
//    @State private var selectedTab = 0
    @EnvironmentObject private var router: NavigationRouter
    
    var body: some View {
        TabView {
            Tab("Home", image: "home") {
                HomeView()
            }
            Tab("Pay", image: "pay") {
                // PayView()
                Text("Pay")
            }
            Tab("Order", image: "order") {
                // OrderView()
                Text("Order")
            }
            Tab("Shop", image: "shop") {
                ShopView()
            }
            Tab("Other", image: "other") {
                OtherView()
            }
        }
        .tint(Color("green02"))
        .onAppear() {
            UITabBar.appearance().backgroundColor = .white00 //탭 바의 배경색
        }
    }
    /*
     var body: some View {
             TabView(selection: $selectedTab) {
                 Tab(value: 0, content: {
                      HomeView()
                 }, label: {
                     VStack {
                         Image(.home)
                             .renderingMode(.template)
                         Text("Home")
                     }
                 })
                 
                 Tab(value: 1, content: {
                     // PayView()
                     Text("Pay")
                 }, label: {
                     VStack {
                         Image(.pay)
                             .renderingMode(.template)
                         Text("Pay")
                     }
                 })
                 
                 Tab(value: 2, content: {
                     // OrderView()
                     Text("Order")
                 }, label: {
                     VStack {
                         Image(.order)
                             .renderingMode(.template)
                         Text("Order")
                     }
                 })
                 
                 Tab(value: 3, content: {
                     // ShopView()
                     Text("Shop")
                 }, label: {
                     VStack {
                         Image(.shop)
                             .renderingMode(.template)
                         Text("Shop")
                     }
                 })

                 Tab(value: 4, content: {
                      OtherView()
                 }, label: {
                     VStack {
                         Image(.other)
                             .renderingMode(.template)
                         Text("Other")
                     }
                 })
             }
             .tint(Color("green02"))
         }
     */
}

#Preview {
    TabBarView()
}
