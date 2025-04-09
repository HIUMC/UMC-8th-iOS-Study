//
//  SignupViewModel.swift
//  Starbucks
//
//  Created by 박정환 on 3/29/25.
//


import Foundation
import SwiftUI
import Observation


@Observable
class SignupViewModel {
    // 모델 변수 선언 (뷰에서 입력받을 데이터)
    var nickname: String = ""
    var email: String = ""
    var password: String = ""
        
    // @AppStorage를 이용해 데이터 저장하기
    @AppStorage("nickname") var storedNickname: String = ""
    @AppStorage("email") var storedEmail: String = ""
    @AppStorage("password") var storedPassword: String = ""
    
    // AppStorage에 데이터를 저장하는 함수
    func saveToAppStorage() {
        storedNickname = nickname
        storedEmail = email
        storedPassword = password
    }
}
