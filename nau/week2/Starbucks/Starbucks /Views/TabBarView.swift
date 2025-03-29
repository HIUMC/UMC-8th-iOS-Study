//
//  SwiftUIView.swift
//  Starbucks
//
//  Created by nau on 3/26/25.
//

import SwiftUI
import UIKit

struct TabBarView: View {
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        TabView {
            Tab("Home", image: "hometab") {
                HomeView()
            }//assets에 render as를 template Image로 바꾸면 tint가 적용됨
            Tab("Pay", image: "paytab") {
                HomeView()
            }
            Tab("Order", image: "ordertab") {
                HomeView()
            }
            Tab("Shop", image: "shoptab") {
                HomeView()
            }
            Tab("Other", image: "othertab") {
                OtherView()
            }
        }.tint(Color(.green02))
    }
}

#Preview {
    TabBarView()
}
