//
//  LoginViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/25/25.

import Foundation
import SwiftUI

final class LoginViewModel: ObservableObject {
    
    /// 사용자 입력 아이디
    @Published var id: String = ""
    /// 사용자 입력 비밀번호
    @Published var pwd: String = ""
    @Published var isLoggedIn: Bool = false
    
    private let service = "com.minjung.keychain.login"
    private let keychain = KeychainService.shared
    
    /// 이메일/비번 로그인 시도
    /// - Returns: 성공하면 true, 실패하면 false
    func loginWithEmail() {
      guard let saved = keychain.load(account: id, service: service) else {
        print("저장된 정보 없음"); return
      }
      if saved == pwd {
        print("로그인 성공")
        isLoggedIn = true                // ← 성공하면 플래그!
      } else {
        print("비밀번호 불일치")
      }
    }
    
    /// 회원가입 시 키체인에 저장
    /// - Returns: 저장 성공 시 true
    func signupWithEmail() -> Bool {
        keychain.savePasswordToKeychain(
            account: id,
            service: service,
            password: pwd
        ) == errSecSuccess
    }
    
    /// 로그인/인가가 완전히 끝나면 true로 바뀌며, 뷰에서 화면 전환에 사용
    
    
    var kakaoAuthURL: URL? {
        let urlString = """
        https://kauth.kakao.com/oauth/authorize\
        ?client_id=\(KakaoKeys.restAPIKey)\
        &redirect_uri=\(KakaoKeys.redirectURI)\
        &response_type=code
        """
        return URL(string: urlString)
    }
    
    
    /// ② Redirect URI로 돌아왔을 때, 호출할 메서드
    ///    받은 URL에서 `code`를 파싱해 토큰 교환 로직으로 넘깁니다.
    func handleKakaoRedirect(_ url: URL) {
        guard let code = URLComponents(
                url: url,
                resolvingAgainstBaseURL: true
              )?
              .queryItems?
              .first(where: { $0.name == "code" })?
              .value
        else {
            print("인가 코드 파싱 실패")
            return
        }
        
        exchangeCodeForToken(code)
    }
    
    
    /// ③ 실제 Alamofire 요청 → ServiceManager를 통해 분리
    private func exchangeCodeForToken(_ code: String) {
        ServiceManager.shared.requestKakaoToken(
            code: code,
            restAPIKey: KakaoKeys.restAPIKey,
            redirectURI: KakaoKeys.redirectURI
        ) { [weak self] result in
            switch result {
            case .success(let resp):
                // ④ 토큰을 KeychainToken에 저장
                let info = TokenInfo(
                    accessToken:  resp.accessToken,
                    refreshToken: resp.refreshToken
                )
                KeychainToken.shared.saveToken(info)
                
                // ⑤ 로그인 완료 플래그 변경 (UI 전환)
                DispatchQueue.main.async {
                    self?.isLoggedIn = true
                }
                
            case .failure(let err):
                print("카카오 토큰 교환 실패:", err)
            }
        }
    }
    
    // MARK: — 내부 타입들
    
    /// ServiceManager로 전달받은 JSON 디코딩용
    private struct OAuthTokenResponse: Codable {
        let accessToken:  String
        let refreshToken: String
        
        enum CodingKeys: String, CodingKey {
            case accessToken  = "access_token"
            case refreshToken = "refresh_token"
        }
    }
}

