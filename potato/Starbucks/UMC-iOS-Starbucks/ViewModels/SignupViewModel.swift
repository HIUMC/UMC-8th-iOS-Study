//
//  SignupViewModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/30/25.
//

import Foundation
import SwiftUI

class SignupViewModel: ObservableObject {
    let userModel: SignupModel = .init(nickname: "", email: "", password: "")
    
    @AppStorage("nickname") var nickname: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("password") var password: String = ""
    
    public func createUser(nickname: String, email: String, password: String) {
        self.nickname = nickname
        self.email = email
        self.password = password
    }
}
