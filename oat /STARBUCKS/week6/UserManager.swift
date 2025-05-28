//
//  UserManager.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/16/25.
//

import Foundation

class UserManager: ObservableObject {
    static let shared = UserManager()

    @Published var isLoggedIn = false
    @Published var email = ""
    @Published var nickname = ""

    private let service = "com.minjung.keychain.login"
    private let keychain = KeychainService.shared

    private init() {
        autoLogin()
    }

    func autoLogin() {
        // 마지막 이메일을 UserDefaults에서 불러오고,
        if let savedEmail = UserDefaults.standard.string(forKey: "lastEmail"),
           let savedPwd = keychain.load(account: savedEmail, service: service) {
         
            self.email = savedEmail
            self.nickname = "오트"
            self.isLoggedIn = true
            print("자동 로그인 성공")
        } else {
            print("자동 로그인 불가")
        }
    }

    func login(email: String, nickname: String) {
        self.email = email
        self.nickname = nickname
        self.isLoggedIn = true
        UserDefaults.standard.set(email, forKey: "lastEmail")
    }

    func logout() {
        self.email = ""
        self.nickname = ""
        self.isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "lastEmail")
    }
}
