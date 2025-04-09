//
//  UMC_iOS_StarbucksApp.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/30/25.
//

import SwiftUI

@main
struct UMC_iOS_StarbucksApp: App {
    @StateObject private var router = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SplashView()
                    .environmentObject(router)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .home:
                            HomeView()
                                .environmentObject(router)
                        case .login:
                            LoginView()
                                .environmentObject(router)
                        case .signup:
                            SignupView()
                                .environmentObject(router)
                        case .tab:
                            TabBarView()
                                .environmentObject(router)
                        case .ad:
                            AdView()
                                .environmentObject(router)
                        case .receipts:
                            ReceiptsView()
                                .environmentObject(router)
                        }
                    }
            }
        }
    }
}
