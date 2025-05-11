//
//  LoginViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 3/26/25.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var userID: String = ""
    @Published var password: String = ""
    @Published var loginStatusMessage: String?
    @Published var isLoginSuccess: Bool = false

    func login() {
        guard let storedUser = KeychainService.shared.loadUser() else {
            loginStatusMessage = "저장된 사용자 정보가 없습니다."
            isLoginSuccess = false
            return
        }

        if storedUser.userID == userID && storedUser.password == password {
            loginStatusMessage = "로그인 성공!"
            isLoginSuccess = true
        } else {
            loginStatusMessage = "아이디 또는 비밀번호가 일치하지 않습니다."
            isLoginSuccess = false
        }
    }
}


