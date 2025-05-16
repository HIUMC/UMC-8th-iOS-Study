//
//  LoginViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/24/25.
//
import SwiftUI
import Foundation

class LoginViewModel: ObservableObject {
    let keychain = KeychainService.shared//Keychain은 민감데이터 저장
    
    @Published var id: String = ""
    @Published var pwd: String = ""
    @Published var nickname: String=""

    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false//앱 상태 전환용, 화면 조건 분기

    
    func isValid() -> Bool {
           // id와 pwd가 비어있지 않으면 로그인 성공
           return !id.isEmpty && !pwd.isEmpty
       }
    
    
    func login() {
        keychain.savePasswordToKeychain(account: "userId", service: "login", password: id)
        keychain.savePasswordToKeychain(account: "userPwd", service: "login", password: pwd)
        keychain.savePasswordToKeychain(account: "userNickname", service: "login", password: nickname)
        isLoggedIn = true
    }

    // 자동 로그인
    func tryAutoLogin() {
        if keychain.readPasswordFromKeychain(account: "userId", service: "login") != nil,
           keychain.readPasswordFromKeychain(account: "userPwd", service: "login") != nil {
            isLoggedIn = true
        }
    }

    // 닉네임 가져오기
    func getNickname() -> String {
        keychain.readPasswordFromKeychain(account: "userNickname", service: "login") ?? "닉네임 없음"
    }

    // 로그아웃
    func logout() {
        keychain.delete(account: "userId", service: "login")
        keychain.delete(account: "userPwd", service: "login")
        keychain.delete(account: "userNickname", service: "login")
        isLoggedIn = false
    }

}
