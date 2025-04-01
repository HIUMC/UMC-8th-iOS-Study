//
//  Starbucks_App_App.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/20/25.
//

import SwiftUI

@main
struct StarbucksApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: LoginViewModel())  // 프리뷰에서 ViewModel 인스턴스 전달
            SplashView()
            SignupView(viewModel:SignupViewModel())
            MainTabView()


        }
    }
}
