//
//  SignupViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 3/26/25.
//

import Observation
import SwiftUI

class SignupViewModel: ObservableObject{
    
    @AppStorage("newID") var newID: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("newPassword") var newPassword: String = ""
    
    @Published var signupModel: SignupModel = .init(newID: "", email: "", newPassword: "")
    
    public func saveAppStorage() {
        print("성공적으로 appStorage에 저장되었습니다!")
        self.newID = signupModel.newID
        self.email = signupModel.email
        self.newPassword = signupModel.newPassword
        // 사용자가 전달하는 id, email, password를 UserDefaults에 저장
    }
}

