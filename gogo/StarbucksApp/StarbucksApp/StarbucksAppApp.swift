//
//  StarbucksAppApp.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/2/25.
//

import SwiftUI

@main
struct StarbucksApp: App {
    @StateObject private var router = NavigationRouter()
    @State private var showSplash = true // 처음엔 Splash 표시

    var body: some Scene {
        WindowGroup {
//            NavigationStack(path: $router.path) {
//                SplashView()
//                    .navigationDestination(for: Route.self) { route in
//                        switch route {
//                        case .signup:
//                            SignupView(signupViewModel: SignupViewModel())
//                        case .login:
//                            LoginView(viewModel: LoginViewModel())
//                        case .detailCoffee:
//                            DetailCoffeeView(viewModel: HomeViewModel())
//                        case .tabBar:
//                            TabBarView()
//                        case .ad:
//                            AdView()
//                        case .goToReceipt:
//                            ReceiptsView()
//                        }
//                    }
//            }
//            .environmentObject(router)
//            
//            /// 4주차 떄 배운, SwiftData. 영속성!
//            .modelContainer(for: ReceiptsModel.self)
           OrderView()
            
        }
    }
}
