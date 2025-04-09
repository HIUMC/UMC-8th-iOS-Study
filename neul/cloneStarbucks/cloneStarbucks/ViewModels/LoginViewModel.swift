//
//  LoginViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/22/25.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var pwd: String = ""
    
    @AppStorage("nickname") var nickname: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("pwd") var storedPwd: String = ""
    
    func login() -> Bool {
        if id == email && pwd == storedPwd {
            return true
        } else {
            return false
        }
    }
}
