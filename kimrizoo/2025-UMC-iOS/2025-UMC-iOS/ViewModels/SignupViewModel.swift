//
//  SignupViewModel.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 3/25/25.
//

import SwiftUI

@Observable
class SignupViewModel {
    @ObservationIgnored @AppStorage("nickname") private var storedNickname: String = ""
    @ObservationIgnored @AppStorage("email") private var storedEmail: String = ""
    @ObservationIgnored @AppStorage("password") private var storedPassword: String = ""
    
    var nickname: String {
        get { storedNickname }
        set { storedNickname = newValue }
    }
    
    var email: String {
        get { storedEmail }
        set { storedEmail = newValue }
    }
    
    var password: String {
        get { storedPassword }
        set { storedPassword = newValue }
    }
    
    func signup() {
        // 저장 로직은 속성의 setter에서 자동으로 처리됨
    }
}
