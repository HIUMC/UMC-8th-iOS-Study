//
//  SignupViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import Foundation
import SwiftUI

/*
@Observable.
class SignupViewModel {
    
    var signupModel = SignupModel(nickname: "", emailAccount: "", password: "")
    
    @AppStorage("name") private var storedNickname: String = ""
    @AppStorage("email") private var storedEmailAccount: String = ""
    @AppStorage("pwd") private var storedPassword: String = ""
    
    func saveUserData() {
        storedNickname = signupModel.nickname
        storedEmailAccount = signupModel.emailAccount
        storedPassword = signupModel.password
    }
}
*/

//@Observable 과 @Appstorage를 같이 쓰면 가끔 문제가 생기나봄...?



class SignupViewModel: ObservableObject {
    @Published var signupModel = SignupModel(nickname: "", emailAccount: "", password: "")
    
    @AppStorage("nickname") var nickname: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("pwd") var pwd: String = ""

    func saveUserData() { //지피티의 도움..
        nickname = signupModel.nickname
        email = signupModel.emailAccount
        pwd = signupModel.password
    }
}
