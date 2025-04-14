//
//  RootView.swift
//  Starbucks
//
//  Created by nau on 4/3/25.
//

import SwiftUI

struct RootView: View {
    @State private var router = NavigationRouter()
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            // 초기 진입 뷰
            /*ReceiptView()
             .environment(router)
             */
            
            LoginView()
                .environment(router)
            
            
                // Route enum에 따라 화면 전환
                .navigationDestination(for: Route.self) { route in
                    switch route {
                        
                    case .login:
                        LoginView()
                            .environment(router)
                        
                    case .signup:
                        SignupView()
                            .environment(router)
                        
                    case .tab:
                        TabBarView()
                            .environment(router)
                            .environment(viewModel)
                        
                    case .detail(let menu):
                        DetailMenuView(menu: menu)
                            .environment(router)
                            .environment(viewModel)
                        
                    case .receipt:
                        ReceiptView()
                            .environment(router)
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
