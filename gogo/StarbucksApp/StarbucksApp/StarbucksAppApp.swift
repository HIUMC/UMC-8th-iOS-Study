////
////  StarbucksAppApp.swift
////  StarbucksApp
////
////  Created by 고석현 on 4/2/25.

//
//import SwiftUI
//import KakaoSDKCommon
//import KakaoSDKAuth
//
//@main
//struct StarbucksApp: App {
//    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
//    init() {
//            KakaoSDK.initSDK(appKey: "4a44882e28b79e70bfb159cf7f6781bb") //  카카오 SDK 초기화
//        }
//    var body: some Scene {
//        WindowGroup {
//            RootLoginHandlerView()
//        }
//    }
//    }
//
////  로그인 상태를 확인한 뒤  루트 뷰
//    struct RootLoginHandlerView: View {
//        @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
//        
//        @State private var didCheckLogin = false
//
//        var body: some View {
//            
//                if !didCheckLogin {
//                    // 앱 실행 시 최초 1회, Keychain에 저장된 이메일/비밀번호 존재 여부로 로그인 상태 확인
//                    Color.clear
//                        .onAppear {
//                            //  Keychain에서 저장된 사용자 계정 정보를 불러옴
//                            let email = KeychainAccountService.shared.load(for: .email)
//                            let password = KeychainAccountService.shared.load(for: .password)
//                            if let email = email, !email.isEmpty,
//                               let password = password, !password.isEmpty {
//                                isLoggedIn = true
//                            }
//                            didCheckLogin = true
//                        }
//                } else {
//                    //  로그인된 상태이면 TabBarView(메인 앱 UI)로 이동
//                    if isLoggedIn {
//                        TabBarView()
//                    //  로그인 정보가 없으면 로그인 화면으로 이동
//                    } else {
//                        LoginView()
//                            
//                    }
//                }
//            
//        }
//    }
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
