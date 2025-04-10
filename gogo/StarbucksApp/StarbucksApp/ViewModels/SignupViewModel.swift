//
//  SignupViewModel.swift
////  Starbucks_Week1_gogo
////
////  Created by 고석현 on 4/1/25.
////
//
import Foundation
import SwiftUI

class SignupViewModel: ObservableObject {
    
    @AppStorage("nickname")  var nickname : String = ""
    @AppStorage("email")  var email : String = ""
    @AppStorage("password")  var password : String = ""
    
   
    
    @Published var signupModel: SignupModel = .init(nickname: "", email: "", password: "")
    
    
    //SignupViewModel 이라는 클래스의 메소드 속성 함수 선언. 객체의 닉네임,이메일,비밀번호를 받음.
    public func saveStorage(){
        self.nickname = signupModel.nickname
        self.email = signupModel.email
        self.password = signupModel.password
        print("AppStorage에 저장됌.")
    }
    
    //한글자 유용성 검사 
    var isValidInput: Bool {
            !signupModel.nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !signupModel.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
            !signupModel.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    
}

