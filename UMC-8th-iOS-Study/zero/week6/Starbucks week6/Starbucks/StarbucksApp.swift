//
//  StarbucksApp.swift
//  Starbucks
//
//  Created by 김영택 on 3/21/25.
//

import SwiftUI
import KakaoSDKCommon

@main
struct StarbucksApp: App {
    init() {
            // kakao sdk 초기화
            let kakaoAppKey = (Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String) ?? ""
            KakaoSDK.initSDK(appKey: kakaoAppKey)
        }
    var body: some Scene {
        WindowGroup {
            AppRootView()
            //LoginView(viewModel: LoginViewModel(), signupViewModel: SignupViewModel())  // 프리뷰에서 ViewModel 인스턴스 전달
            //SplashView()
            //SignupView(viewModel:SignupViewModel())
            //AdView()
            //BottomTabView()
            //HomeView()
            //OtherView()
            //CircleImageCardView()
            //ShopView()
            /*OrderView()
                .environment(NavigationRouter())
                .environment(MapListViewModel())
        */

        }
    }
}
