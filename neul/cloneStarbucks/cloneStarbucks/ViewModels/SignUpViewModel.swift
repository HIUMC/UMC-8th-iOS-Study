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
    @Published var hasLoggedIn: Bool = false
    
    let keychain = KeychainService.shared
    
    public func saveToAppStorage() {
        if checkValidation() {
            nickname = signUpModel.nickname
            email = signUpModel.email
            pwd = signUpModel.pwd
            print("saveToAppStorage : \(signUpModel)")
            hasLoggedIn = true
        } else {
            print("저장 실패")
        }
    }
    
    func saveToKeychain() {
        if checkValidation() {
            let signUp = keychain.savePasswordToKeychain(email: signUpModel.email, service: "com.cloneStarbucks.login", password: signUpModel.pwd, nickname: signUpModel.nickname)
            if signUp == errSecSuccess {
                keychain.saveMasterKey(email: signUpModel.email, service: "com.cloneStarbucks.autoLogin")
                print("회원가입 정보 저장 성공")
            } else {
                print("회원가입 정보 저장 실패:", signUp)
            }
        }
    }
    
    private func checkValidation() -> Bool {
        return !signUpModel.nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               !signUpModel.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               !signUpModel.pwd.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    func getNickName() -> String {
        if let savedId = keychain.load(account: "autoLogin", service: "com.cloneStarbucks.autoLogin") {
            let savedInfo = keychain.loadLabel(account: savedId, service: "com.cloneStarbucks.login")
            return savedInfo ?? "(작성한 닉네임)"
        } else {
            return "(작성한 닉네임)"
        }
    }
    
    func logOut() {
        let deleteStatus = keychain.delete(account: "autoLogin", service: "com.cloneStarbucks.autoLogin")
        if deleteStatus == errSecSuccess {
            print("비밀번호 삭제 완료")
        } else {
            print("비밀번호 삭제 실패:", deleteStatus)
        }
    }
        
    

    
}
