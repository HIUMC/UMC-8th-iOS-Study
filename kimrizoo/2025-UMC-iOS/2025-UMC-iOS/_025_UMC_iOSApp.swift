//
//  _025_UMC_iOSApp.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 3/19/25.
//

import SwiftUI

@main
struct _025_UMC_iOSApp: App {
    @StateObject private var router = NavigationRouter()
    @StateObject private var detailViewModel = MenuDetailViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                HomeView()
                    .environmentObject(router)
                    .environmentObject(detailViewModel)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .signup:
                            SignupView()
                                .environmentObject(router)
                            
                        case .cafeMenu(let menu):
                            MenuDetailView(menu: menu)
                                .environmentObject(detailViewModel)
                                .environmentObject(router)
                        }
                    }
            }
        }
    }
}
