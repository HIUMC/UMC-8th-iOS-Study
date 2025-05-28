//
//  LoginViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/25/25.
import Foundation
import SwiftUI        // ObservableObject

final class LoginViewModel: ObservableObject {
   
    @Published var id: String = ""
    @Published var pwd: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var nickname: String = ""


    private let service = "com.minjung.keychain.login"
    private let keychain = KeychainService.shared


    func loginWithEmail() {
        guard let saved = keychain.load(account: id, service: service) else {
            print("저장된 정보 없음")
            return
        }
        if saved == pwd {
            print("로그인 성공")

            // ✅ 이미 저장해둔 닉네임을 꺼내오자
            let savedNickname = keychain.load(account: "nickname", service: service)
            UserManager.shared.nickname = savedNickname ?? ""

            isLoggedIn = true
        } else {
            print("비밀번호 불일치")
        }
    }

  
    @discardableResult
    func signupWithEmail() -> Bool {
        return keychain.savePasswordToKeychain(
            account: id,
            service: service,
            password: pwd
        ) == errSecSuccess
    }


}
