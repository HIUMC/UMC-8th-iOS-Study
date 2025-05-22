//
//  UMC_StarbucksApp.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
struct UMC_StarbucksApp: App {
    init() {
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "OSRM_BASE_URL") as? String {
            print("✅ baseURL: \(urlString)")
        }
        if let appKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String {
            KakaoSDK.initSDK(appKey: appKey)
        } else {
            print("❌ Kakao App Key 불러오기 실패")
        }

        var loginSuccess = false

        // Kakao 자동 로그인 시도
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { _, error in
                if let _ = error {
                    print("⛔️ 유효하지 않은 Kakao 토큰")
                } else {
                    print("✅ Kakao 자동 로그인 성공")
                    UserDefaults.standard.set(true, forKey: "isLoginOK")
                }
            }
        }

        // 이메일(Keychain) 로그인 시도
        if let saved = KeychainService.shared.loadTokenInfo() {
            print("✅ 키체인 자동 로그인 정보 확인됨: \(saved.nickname)")
            loginSuccess = true
        }

        // 결과 반영
        UserDefaults.standard.set(loginSuccess, forKey: "isLoginOK")
    }
    
    @AppStorage("isLoginOK") var isLoginOK: Bool = false
    var body: some Scene {
        WindowGroup {
            SplashView()
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
            /*
            if isLoginOK {
                TabBarView()
            } else {
                LoginView()
            }
             */
            
        }
        
    }
}
