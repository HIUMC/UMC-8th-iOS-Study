//
//  StarbucksApp.swift
//  Starbucks
//
//  Created by 박정환 on 4/2/25.
//

import SwiftUI
import SwiftData
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct StarbucksApp: App {
    @StateObject private var router = NavigationRouter()
    
    init() {
        // kakao sdk 초기화
        let kakaoNativeAppKey = (Bundle.main.infoDictionary?["d441e529f6c27f346f64387ae7b6ad92"] as? String) ?? ""
        KakaoSDK.initSDK(appKey: kakaoNativeAppKey)
    }
    
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
                            ReceiptView()
                                .navigationBarBackButtonHidden(true)
                        case .storeMap:
                            FindStoreView()
                        }
                    }
            }
            .environmentObject(router)
            .modelContainer(for: ReceiptModel.self)
            //로그인 URL
            .onOpenURL(perform: { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}
