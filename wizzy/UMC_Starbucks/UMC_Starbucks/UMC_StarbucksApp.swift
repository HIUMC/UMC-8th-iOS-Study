//
//  UMC_StarbucksApp.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI

@main
struct UMC_StarbucksApp: App {
    @AppStorage("isLoginOK") var isLoginOK: Bool = true
    var body: some Scene {
        WindowGroup {
            HomeView()
            /*
            if isLoginOK {
                TabBarView()
            } else {
                LoginView()
            }
             */
            
        }
    }
}
