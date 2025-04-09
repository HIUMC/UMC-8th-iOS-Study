//
//  SignupModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import Foundation

@Observable
class SignupModel {
    var nickname: String
    var emailAccount: String
    var password: String

    init(nickname: String, emailAccount: String, password: String) {
        self.nickname = nickname
        self.emailAccount = emailAccount
        self.password = password
    }
    
    
}
