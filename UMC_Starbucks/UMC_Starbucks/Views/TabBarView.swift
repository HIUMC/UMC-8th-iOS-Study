//
//  TabBarView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = 0
    
    /*
     var body: some View {
     HStack {
     TabView(selection: $selectedTab) {
     Text("")
     .tabItem {
     Image(selectedTab == 0 ? "icon1" : "icon1gray")
     }
     } // 탭뷰1
     
     
     TabView(selection: $selectedTab) {
     Text("")
     .tabItem {
     Image(selectedTab == 0 ? "icon2" : "icon2gray")
     }
     }//탭뷰2
     
     
     TabView(selection: $selectedTab) {
     Text("")
     .tabItem {
     Image(selectedTab == 0 ? "icon3" : "icon3gray")
     }
     } //탭뷰3
     
     TabView(selection: $selectedTab) {
     Text("")
     .tabItem {
     Image(selectedTab == 0 ? "icon4" : "icon4gray")
     }
     } //탭뷰4
     
     
     TabView(selection: $selectedTab) {
     Text("")
     .tabItem {
     Image(selectedTab == 0 ? "icon5" : "icon5gray")
     }
     } //탭뷰5
     
     } //H
     }
     }
     */
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            Text("")
                .tabItem {
                    Image(selectedTab == 0 ? "icon1" :  "icon1gray")
                } //selectedTab == x 조건에서 쓰임
                .tag(0) //SwiftUI가 이 탭이 몇 번째 탭인지 인식
            
            Text("")
                .tabItem {
                    Image(selectedTab == 1 ? "icon2" : "icon2gray")
                }
                .tag(1)
            
            Text("")
                .tabItem {
                    Image(selectedTab == 2 ? "icon3" : "icon3gray")
                }
                .tag(2)
            
            Text("")
                .tabItem {
                    Image(selectedTab == 3 ? "icon4" : "icon4gray")
                }
                .tag(3)
            
            OtherView()
                .tabItem {
                    Image(selectedTab == 4 ? "icon5" : "icon5gray")
                }
                .tag(4)
        }
        
    }
}

#Preview {
    TabBarView()
}
