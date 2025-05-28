//
//  RootView.swift
//  Starbucks
//
//  Created by nau on 4/3/25.
//

import SwiftUI
import KakaoSDKAuth

struct RootView: View {
    @State private var router = NavigationRouter()
    @State private var viewModel = HomeViewModel()
    @State private var viewModel1 = DetailMenuViewModel(currentMenu: .placeholder, allMenus: [])
    @State private var viewModel2 = OrderViewModel()
    @State private var viewModel3 = MapListViewModel()
    @State private var viewModel4 = MapViewModel()
    @State private var viewModel5 = WayFindViewModel()

    var body: some View {
        NavigationStack(path: $router.path) {
            // 초기 진입 뷰
            
            TabBarView()
                .environment(router)
                .environment(viewModel)
                .environment(viewModel1)
                .environment(viewModel2)
                .environment(viewModel3)
            
            
            /*
            LoginView()
                .environment(router)
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
            */
            
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
                            .environment(viewModel1)
                            .environment(viewModel2)
                            .environment(viewModel3)
                        
                    case .detail(let menu):
                        DetailMenuView(menu: menu)
                            .environment(router)
                            .environment(viewModel1)
                        
                    case .receipt:
                        ReceiptView()
                            .environment(router)
                        
                    case .storeFind:
                        StoreFindView()
                            .environment(router)
                            .environment(viewModel4)
                            .environment(viewModel5)
                    }
                }
        }
    }
}

/*
#Preview {
    RootView()
}
*/
