//
//  SignupViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/26/25.
//
import Foundation

class SignupViewModel: ObservableObject {
    @Published var nickname = ""
    @Published var email = ""
    @Published var pwd = ""

    private let keychain = KeychainService.shared
    private let service = "com.minjung.keychain.login"

    func saveToKeychain() -> Bool {
        print("⭐️ 저장 시 닉네임:", nickname)
        
        let pwdSaved = keychain.savePasswordToKeychain(account: email, service: service, password: pwd)
        
        let nickSaved = keychain.savePasswordToKeychain(account: "nickname", service: service, password: nickname)
        
        print("닉네임 저장 결과 코드: \(nickSaved)")
        return pwdSaved == errSecSuccess && nickSaved == errSecSuccess
    }

}






