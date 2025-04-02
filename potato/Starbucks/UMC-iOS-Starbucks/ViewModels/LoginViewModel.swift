//
//  LoginViewModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/30/25.
//

import Foundation

@Observable
class LoginViewModel {
    let loginModel: LoginModel = .init(id: "", pwd: "")
    
    var id = ""
    var pwd = ""
}
