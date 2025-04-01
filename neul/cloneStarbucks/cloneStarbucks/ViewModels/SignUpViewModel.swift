//
//  SignUpViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/29/25.
//

import Foundation
import SwiftUI

// 해결 방법: Observable로 해보고자 했으나... AppStorage에 저장된 값이 실시간으로 반영 ㄴㄴ
/*@Observable
class SignUpViewModel {
    @ObservationIgnored 
    @AppStorage("nickname") var nickname: String = ""
    @ObservationIgnored  
    @AppStorage("email") var email: String = ""
    @ObservationIgnored  
    @AppStorage("pwd") var pwd: String = ""
    
    var signUpModel: SignUpModel = SignUpModel(nickname: "", email: "", pwd: "")
    
    public func saveToAppStorage() {
        nickname = signUpModel.nickname
        email = signUpModel.email
        pwd = signUpModel.pwd
    }
}*/

class SignUpViewModel: ObservableObject {
    @AppStorage("nickname") var nickname: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("pwd") var pwd: String = ""
    
    @Published var signUpModel: SignUpModel = SignUpModel(nickname: "", email: "", pwd: "")
    
    public func saveToAppStorage() {
        print("saveToAppStorage : \(signUpModel.nickname)")
        nickname = signUpModel.nickname
        email = signUpModel.email
        pwd = signUpModel.pwd
    }
    
}
