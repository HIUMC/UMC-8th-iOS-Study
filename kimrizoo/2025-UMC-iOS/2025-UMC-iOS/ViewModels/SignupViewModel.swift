//
//  SignupViewModel.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 3/25/25.
//

import Foundation
import SwiftUI

class SignupViewModel: ObservableObject {
    
    @AppStorage("nickname") private var storedNickname: String = ""
    @AppStorage("email") private var storedEmail: String = ""
    @AppStorage("password") private var storedPassword: String = ""

    // @Published 추가 → 뷰에서 자동으로 변경 감지 가능
    @Published var nickname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""

    init() {
        loadSignupInfo()
    }

    public func signup() {
        saveSignupInfo()
    }

    private func saveSignupInfo() {
        storedNickname = nickname
        storedEmail = email
        storedPassword = password
    }

    private func loadSignupInfo() {
        nickname = storedNickname
        email = storedEmail
        password = storedPassword
    }
}
