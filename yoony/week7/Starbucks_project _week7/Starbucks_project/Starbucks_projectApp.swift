//
//  Starbucks_projectApp.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/20/25.

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct Starbucks_projectApp: App {
    
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    init() {
        // Kakao SDK 초기화
        let kakaoAppKey = (Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String) ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoggedIn {
                    TabBarView()
                } else {
                    NavigationStack {
                        LoginView()
                    }
                }
            }
            .onOpenURL { url in
                if AuthApi.isKakaoTalkLoginUrl(url) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
    /*
    var body: some Scene {
        WindowGroup {
            
            OrderSheetView()
        }
    }
*/
}

