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
    @State private var showSplash = true //  처음엔 Splash 표시
    
    var body: some Scene {
            WindowGroup {
                if showSplash {
                    SplashView()
                        .onAppear {
                            //  2초 뒤에 SplashView를 false로 전환
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showSplash = false
                                    router.push(.login) //  로그인 뷰로 이동
                                }
                            }
                        }
                } else {
                    NavigationStack(path: $router.path) {
                        EmptyView() // 초기 경로 → push로 화면 뜸
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
                                case .detailCoffee:
                                    DetailCoffeeView(viewModel: HomeViewModel())
                                        .navigationBarBackButtonHidden(true)
                                case .ad:
                                    AdView()
                                }
                            }
                    }
                    .environmentObject(router)
                }
            }
        }
    }

