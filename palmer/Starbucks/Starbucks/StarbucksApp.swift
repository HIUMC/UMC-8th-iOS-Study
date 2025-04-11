//
//  StarbucksApp.swift
//  Starbucks
//
//  Created by 박정환 on 4/2/25.
//

import SwiftUI
import SwiftData

@main
struct StarbucksApp: App {
    @StateObject private var router = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SplashView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .login:
                            LoginView(viewModel: LoginViewModel())
                                .navigationBarBackButtonHidden(true)
                        case .signup:
                            SignupView(signupViewModel: SignupViewModel())
                                .navigationBarBackButtonHidden(true)
                        case .tabBar:
                            TabBarView()
                                .navigationBarBackButtonHidden(true)
                        case .coffeeDetail:
                            CoffeeDetailView(viewModel: HomeViewModel())
                                .navigationBarBackButtonHidden(true)
                        case .receipts:
                            ReceiptsView()
                                .navigationBarBackButtonHidden(true)
                        }
                    }
            }
            .environmentObject(router)
            .modelContainer(for: ReceiptsModel.self)
        }
    }
}
