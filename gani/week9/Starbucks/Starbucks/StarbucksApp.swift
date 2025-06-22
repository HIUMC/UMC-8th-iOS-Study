//
//  StarbucksApp.swift
//  Starbucks
//
//  Created by 이가원 on 3/24/25.
//
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
            Group {
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
                        MainTabView()
                    } else {
                        LoginView()
                    }
                }
            }
        }
    }
}
