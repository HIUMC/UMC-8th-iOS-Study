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
                
            }
            
            Tab("Pay", image: "realcard") {
                
            }
            
            Tab("Order", image: "coffee") {
                
            }
            
            Tab("Shop", image: "bag") {
                
            }
            
            Tab("Other", image: "etc") {
                
            }
        }
        .tint(Color(.greeen2))
    }
}
#Preview {
    MainTabView()
}
