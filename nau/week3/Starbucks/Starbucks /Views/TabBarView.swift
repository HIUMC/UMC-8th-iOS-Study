//
//  SwiftUIView.swift
//  Starbucks
//
//  Created by nau on 3/26/25.
//

import SwiftUI
import UIKit

struct TabBarView: View {
    @Environment(NavigationRouter.self) private var router
    
    var body: some View {
        TabView {
            Tab("Home", image: "hometab") {
                HomeView()
                    .environment(router)
            }//assets에 render as를 template Image로 바꾸면 tint가 적용됨
            Tab("Pay", image: "paytab") {
                HomeView()
                    .environment(router)
            }
            Tab("Order", image: "ordertab") {
                HomeView()
                    .environment(router)
            }
            Tab("Shop", image: "shoptab") {
                HomeView()
                    .environment(router)
            }
            Tab("Other", image: "othertab") {
                OtherView()
                    .environment(router)
            }
        }.tint(Color(.green02))
            .onAppear {
                UITabBar.appearance().backgroundColor = .white
            }.navigationTitle("")
            .navigationBarHidden(true)
    }
}

#Preview {
    TabBarView()
}
