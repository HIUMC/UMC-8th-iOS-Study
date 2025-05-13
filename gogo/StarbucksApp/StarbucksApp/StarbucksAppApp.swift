////
////  StarbucksAppApp.swift
////  StarbucksApp
////
////  Created by 고석현 on 4/2/25.
////
//
//import SwiftUI
//
//@main
//struct StarbucksApp: App {
//    @StateObject private var router = NavigationRouter()
//    @State private var showSplash = true // 처음엔 Splash 표시
//
//    var body: some Scene {
//        WindowGroup {
////            NavigationStack(path: $router.path) {
////                SplashView()
////                    .navigationDestination(for: Route.self) { route in
////                        switch route {
////                        case .signup:
////                            SignupView(signupViewModel: SignupViewModel())
////                        case .login:
////                            LoginView(viewModel: LoginViewModel())
////                        case .detailCoffee:
////                            DetailCoffeeView(viewModel: HomeViewModel())
////                        case .tabBar:
////                            TabBarView()
////                        case .ad:
////                            AdView()
////                        case .goToReceipt:
////                            ReceiptsView()
////                        }
////                    }
////            }
////            .environmentObject(router)
////            
////            /// 4주차 떄 배운, SwiftData. 영속성!
////            .modelContainer(for: ReceiptsModel.self)
//           LoginView(viewModel: LoginViewModel())
//                
//            
//        }
//    }
//}


import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct StarbucksApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    init() {
            KakaoSDK.initSDK(appKey: "673975a5079b04553713d2e69d4cfbcc")
        }
    var body: some Scene {
        WindowGroup {
            RootLoginHandlerView()
        }
    }

    struct RootLoginHandlerView: View {
        @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
        
        @State private var didCheckLogin = false

        var body: some View {
            
                if !didCheckLogin {
                    Color.clear
                        .onAppear {
                            let email = KeychainAccountService.shared.load(for: .email)
                            let password = KeychainAccountService.shared.load(for: .password)
                            if let email = email, !email.isEmpty,
                               let password = password, !password.isEmpty {
                                isLoggedIn = true
                            }
                            didCheckLogin = true
                        }
                } else {
                    if isLoggedIn {
                        TabBarView()
                    } else {
                        LoginView()
                            
                    }
                }
            
        }
    }
}
