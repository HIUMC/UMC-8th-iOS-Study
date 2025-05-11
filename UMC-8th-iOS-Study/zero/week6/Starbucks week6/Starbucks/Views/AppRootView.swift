//
//  AppRootView.swift
//  Starbucks
//
//  Created by 김영택 on 5/11/25.
//

import SwiftUI

struct AppRootView: View {
    @State private var isLoggedIn = false
    @StateObject private var loginViewModel = LoginViewModel()
    @StateObject private var signupViewModel = SignupViewModel()

    var body: some View {
        Group {
            if isLoggedIn {
                BottomTabView()
            } else {
                LoginView(viewModel: loginViewModel, signupViewModel: signupViewModel)
            }
        }
        .onAppear {
            autoLoginIfPossible()
        }
    }

    private func autoLoginIfPossible() {
        if let storedUser = KeychainService.shared.loadUser() {
            // 저장된 정보가 있으면 자동 로그인 처리
            loginViewModel.userID = storedUser.userID
            loginViewModel.password = storedUser.password
            loginViewModel.login()
            if loginViewModel.isLoginSuccess {
                isLoggedIn = true
            }
        }
    }
}

#Preview {
    AppRootView()
}
