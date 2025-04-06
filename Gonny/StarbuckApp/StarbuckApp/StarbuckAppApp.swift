//
//  StarbuckAppApp.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/24/25.
//

import SwiftUI

/*@main
struct StarbuckAppApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView()//앱이 실행될 때 가장 먼저 보여줄 View
        }
    }
}
 */
@main
struct YourAppNameApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MyTabView() // 홈 탭이 포함된 메인 화면
            } else {
                LoginView(userInfo: LoginViewModel())
            }
        }
    }
}
