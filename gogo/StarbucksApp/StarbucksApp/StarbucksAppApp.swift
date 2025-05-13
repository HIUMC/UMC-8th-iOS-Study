////
////  StarbucksAppApp.swift
////  StarbucksApp
////
////  Created by 고석현 on 4/2/25.


import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct StarbucksApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    init() {
            KakaoSDK.initSDK(appKey: "4a44882e28b79e70bfb159cf7f6781bb") //  카카오 SDK 초기화
        }
    var body: some Scene {
        WindowGroup {
            RootLoginHandlerView()
        }
    }
    }

//  로그인 상태를 확인한 뒤  루트 뷰
    struct RootLoginHandlerView: View {
        @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
        
        @State private var didCheckLogin = false

        var body: some View {
            
                if !didCheckLogin {
                    // 앱 실행 시 최초 1회, Keychain에 저장된 이메일/비밀번호 존재 여부로 로그인 상태 확인
                    Color.clear
                        .onAppear {
                            //  Keychain에서 저장된 사용자 계정 정보를 불러옴
                            let email = KeychainAccountService.shared.load(for: .email)
                            let password = KeychainAccountService.shared.load(for: .password)
                            if let email = email, !email.isEmpty,
                               let password = password, !password.isEmpty {
                                isLoggedIn = true
                            }
                            didCheckLogin = true
                        }
                } else {
                    //  로그인된 상태이면 TabBarView(메인 앱 UI)로 이동
                    if isLoggedIn {
                        TabBarView()
                    //  로그인 정보가 없으면 로그인 화면으로 이동
                    } else {
                        LoginView()
                            
                    }
                }
            
        }
    }

