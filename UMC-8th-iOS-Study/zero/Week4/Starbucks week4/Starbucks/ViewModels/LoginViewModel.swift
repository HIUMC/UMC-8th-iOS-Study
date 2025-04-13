//
//  LoginViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 3/26/25.
//

import SwiftUI
import Observation


class LoginViewModel: ObservableObject {
    @Published var userID: String = ""
    @Published var password: String = ""

    func login() {
        print("로그인 버튼 클릭: 아이디 - \(userID), 비밀번호 - \(password)")
    }
}
