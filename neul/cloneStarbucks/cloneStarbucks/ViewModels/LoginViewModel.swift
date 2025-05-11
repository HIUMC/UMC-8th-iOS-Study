//
//  LoginViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/22/25.
//

import Foundation
import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth

class LoginViewModel: ObservableObject {
    @Published var id: String = ""
    @Published var pwd: String = ""
    
    @AppStorage("nickname") var nickname: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("pwd") var storedPwd: String = ""
    
    @Published var isLoggedIn: Bool = false
    
    let keychain = KeychainService.shared
    
    func login() -> Bool {
        if id == email && pwd == storedPwd {
            return true
        } else {
            return false
        }
    }
    
    func keychainLogin() -> Bool {
        if let retrievedPassword = keychain.load(account: id, service: "com.cloneStarbucks.login") {
            //print("불러온 비밀번호:", retrievedPasswrod)
            if pwd == retrievedPassword {
                keychain.saveMasterKey(email: id, service: "com.cloneStarbucks.autoLogin")
                return true
            } else {
                print("비밀번호 다름")
                return false
            }
        } else {
            print("저장된 비밀번호 없음")
            return false
        }
    }
    
    func kakaoLogin() {
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                    if let error = error {
                        print(error)
                    } else {
                        print("카카오톡 로그인 success")
                        guard let token = self.extractToken(from: oauthToken) else { return }
                        self.keychain.saveToken(token)
                        self.isLoggedIn = true
                    }
                
                }
        } else {
            // 카카오계정 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("카카오계정 로그인 success")
                    guard let token = self.extractToken(from: oauthToken) else { return }
                    self.keychain.saveToken(token)
                    self.isLoggedIn = true
                }
            }
        }
        
    }
    
    func extractToken(from token: OAuthToken?) -> TokenInfo? {
        guard let token = token else {
            print("토큰이 없습니다.")
            return nil
        }
        
        let tokenInfo = TokenInfo(
            accessToken: token.accessToken,
            refreshToken: token.refreshToken
        )
        
        return tokenInfo
    }


}
