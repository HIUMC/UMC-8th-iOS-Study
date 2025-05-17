//
//  LoginViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/27/25.
//

import Observation
import SwiftUI

@Observable
class LoginViewModel {
     var userID: String = ""
     var password: String = ""

    func login() {
        print("로그인 버튼 클릭: 아이디 - \(userID), 비밀번호 - \(password)")
    }
}
