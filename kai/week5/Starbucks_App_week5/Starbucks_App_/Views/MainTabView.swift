//
//  TabView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/27/25.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView{
            
            Tab("Home",image: "home"){
                            
                        }
                        
            Tab("Pay",image: "pay"){
                        }
                        
            Tab("Order",image: "order"){
                            
                        }
                        
            Tab("Shop",image: "shop"){
                            
                        }
                        
            Tab("Other",image: "other"){
                            
                        }
            
        
            
        }
        .tint(.tabGreen)
    }
}

#Preview {
    MainTabView()
}
