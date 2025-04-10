//
//  StarbucksAppApp.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/2/25.
//

import SwiftUI

@main
struct StarbucksApp: App {
    @StateObject private var navigationRouter = NavigationRouter() // NavigationRouter 초기화

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(navigationRouter) // environmentObject로 전달
        }
    }
}
