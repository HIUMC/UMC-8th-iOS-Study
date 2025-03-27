//
//  SignupViewModel.swift
//  Starbucks
//
//  Created by nau on 3/25/25.
//

import Foundation
import SwiftUI

class SignupViewModel: ObservableObject {
    
    @AppStorage("nickname") var nickname: String = "(작성한 닉네임)"
    @AppStorage("email") var email: String = ""
    @AppStorage("pwd") var pwd: String = ""
    
    public func createAccount(from model: SignupModel) {
        nickname = model.nickname
        email = model.email
        pwd = model.pwd
    }
}
