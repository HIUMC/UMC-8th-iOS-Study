//
//  SignupViewModel.swift
//  Starbucks
//
//  Created by nau on 3/25/25.
//

import Foundation
import SwiftUI
import Security

class SignupViewModel: ObservableObject {
    
    let keychain = KeychainService.shared
    
    @AppStorage("nickname") var nickname: String = "(작성한 닉네임)"
    
    public func createAccount(from model: SignupModel) {
        nickname = model.nickname
        keychain.saveUserCredential(model)
    }
}
