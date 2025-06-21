//
//  SignupViewModel.swift
//  Starbucks
//
//  Created by 박정환 on 3/29/25.
//

import Foundation
import SwiftUI

class SignupViewModel: ObservableObject {
    @AppStorage("nickname") var nickname: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("password") var password: String = ""
    
    @Published var signupModel: SignupModel = SignupModel(nickname: "", email: "", password: "")
    @Published var hasLoggedIn: Bool = false
    
    let keychain = KeychainService.shared
    
    public func saveToAppStorage() {
        if checkValidation() {
            nickname = signupModel.nickname
            email = signupModel.email
            password = signupModel.password
            print("saveToAppStorage : \(signupModel)")
            hasLoggedIn = true
        } else {
            print("저장 실패")
        }
    }
    
    func saveToKeychain() {
        if checkValidation() {
            let signUp = keychain.savePasswordToKeychain(email: signupModel.email, service: "com.cloneStarbucks.login", password: signupModel.password, nickname: signupModel.nickname)
            if signUp == errSecSuccess {
                keychain.saveMasterKey(email: signupModel.email, service: "com.cloneStarbucks.autoLogin")
                print("회원가입 정보 저장 성공")
            } else {
                print("회원가입 정보 저장 실패:", signUp)
            }
        }
    }
    
    private func checkValidation() -> Bool {
        return !signupModel.nickname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               !signupModel.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
               !signupModel.password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
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
