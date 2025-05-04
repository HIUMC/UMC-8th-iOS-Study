//
//  LoginViewModel 2.swift
//  Starbucks
//
//  Created by 박정환 on 3/31/25.
//


import SwiftUI
import Foundation
import Observation

@Observable
class LoginViewModel {
    
    var id: String = ""  // 아이디 입력값
    var password: String = ""  // 비밀번호 입력값
    var isFocusedId: Bool = false  // 아이디 텍스트 필드 커서 활성화 여부
    var isFocusedPassword: Bool = false  // 비밀번호 텍스트 필드 커서 활성화 여부
}
