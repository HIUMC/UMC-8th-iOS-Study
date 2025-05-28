//
//  LoginViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import Foundation

import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth

class LoginViewModel: ObservableObject {
    @Published var id = ""
    @Published var pwd = ""
    @Published var nickname = ""

    
    
    func kakaoLogin(completion: @escaping () -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    print("❌ 카카오톡 로그인 실패: \(error.localizedDescription)")
                } else {
                    print("✅ 카카오톡 로그인 성공")
                    self?.fetchUserInfo(completion: completion)
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                if let error = error {
                    print("❌ 카카오 계정 로그인 실패: \(error.localizedDescription)")
                } else {
                    print("✅ 카카오 계정 로그인 성공")
                    self?.fetchUserInfo(completion: completion)
                }
            }
        }
    }

    private func fetchUserInfo(completion: @escaping () -> Void) {
        UserApi.shared.me { [weak self] (user, error) in
            if let error = error {
                print("❌ 사용자 정보 요청 실패: \(error.localizedDescription)")
            } else {
                let nickname = user?.kakaoAccount?.profile?.nickname ?? "알 수 없음"
                self?.nickname = nickname
                print("✅ 사용자 닉네임: \(nickname)")

                let tokenInfo = TokenInfo(
                    accessToken: "", // 필요한 경우 oauthToken에서 추출
                    refreshToken: "",
                    nickname: nickname
                )
                KeychainService.shared.saveToken(tokenInfo)
                UserDefaults.standard.set(nickname, forKey: "nickname")
            }
            completion()
        }
    }
}
