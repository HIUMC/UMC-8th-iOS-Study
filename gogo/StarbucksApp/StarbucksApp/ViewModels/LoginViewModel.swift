//
//  LoginViewModel.swift
//  Starbucks_Week1_gogo
//
//  Created by 고석현 on 3/24/25.
//
import SwiftUI
import Foundation
import Observation

@Observable
class LoginViewModel {
    var id: String = ""  // 아이디 입력값
    var password: String = ""  // 비밀번호 입력값
}
