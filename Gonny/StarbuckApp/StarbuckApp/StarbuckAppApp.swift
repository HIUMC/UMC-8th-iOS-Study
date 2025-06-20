//
//  StarbuckAppApp.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/24/25.
//
import SwiftUI
import SwiftData
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct MyApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    init() {
        KakaoSDK.initSDK(appKey: "6898bc7cbafc48a016922cee9e0dff52")
    }

    var body: some Scene {
        WindowGroup {
            LoginHandlingView()
        }
    }
}

struct LoginHandlingView: View {
        @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

        @State private var isLoginComplete = false

        var body: some View {
            
                if !isLoginComplete {
                    Color.clear
                        .onAppear {
                            let email = KeychainService.shared.load(account: "email", service: "StarbuckApp")
                            let password = KeychainService.shared.load(account: "password", service: "StarbuckApp")
                            if let email = email, !email.isEmpty,
                               let password = password, !password.isEmpty {
                                isLoggedIn = true
                            }
                            isLoginComplete = true
                        }
                } else {
                    if isLoggedIn {
                        MyTabView()
                    } else {
                        LoginView(userInfo: LoginViewModel())
                    }
                }
            
        }
    }

