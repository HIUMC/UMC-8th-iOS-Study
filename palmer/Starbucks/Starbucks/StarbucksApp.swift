//
//  StarbucksApp.swift
//  Starbucks
//
//  Created by 박정환 on 4/2/25.
//

import SwiftUI

@main
struct StarbucksApp: App {
    @AppStorage("isLoggedIn") private var isLoggedIn: Bool = false  // 로그인 상태 확인

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                TabBarView()  // 로그인 상태면 TabBarView로 이동
            } else {
                LoginView(loginViewModel: LoginViewModel())  //로그아웃 상태면 LoginView로 이동
            }
        }
    }
}
