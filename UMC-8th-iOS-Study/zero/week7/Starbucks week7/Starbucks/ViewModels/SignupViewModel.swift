//
//  SignupViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 3/26/25.
//

import Observation
import SwiftUI

class SignupViewModel: ObservableObject {
    @Published var newID: String = ""
    @Published var email: String = ""
    @Published var newPassword: String = ""

    public func saveToKeychain() {
        KeychainService.shared.saveUser(userID: newID, password: newPassword)
        print("Keychain에 사용자 정보 저장 완료")
    }
}

