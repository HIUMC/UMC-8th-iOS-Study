//
//  STARBUCKSApp.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/23/25.
//

import SwiftUI

@main
struct MyApp: App {
    // "isLoggedIn" 키로 로그인 상태를 저장 (기본값은 false)
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                iconView()
            } else {
                LoginView()
            }
        }
    }
}

