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
    
    @AppStorage("nickname") private var nickname : String = ""
    @AppStorage("email") private var email : String = ""
    @AppStorage("password") private var password : String = ""
    
   
    
    @Published var signupModel: SignupModel = .init(nickname: "", email: "", password: "")
    
    //SignupViewModel 이라는 클래스의 메소드 속성 함수 선언. 객체의 닉네임,이메일,비밀번호를 받음. 
    public func saveStorage(){
        self.nickname = signupModel.nickname
        self.email = signupModel.email
        self.password = signupModel.password
        print("AppStorage에 저장됌.")
    }
    
}

