//
//  FetchToken.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/19/25.
//

import SwiftUI
import Alamofire

func fetchToken(with code: String) {
    let url = "https://kauth.kakao.com/oauth/token"
    let parameters: [String: String] = [
        "grant_type": "authorization_code",
        "client_id": "4f1fb1b08be15e4edf1d71003fb065ba",
        "redirect_uri": "http://kakao4f1fb1b08be15e4edf1d71003fb065ba://oauth",
        "code": code
    ]

    AF.request(url, method: .post, parameters: parameters)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let token):
                print("Access Token: \(token.access_token)")

                let headers: HTTPHeaders = [
                    "Authorization": "Bearer \(token.access_token)"
                ]

                AF.request("https://kapi.kakao.com/v2/user/me", headers: headers)
                    .validate()
                    .responseDecodable(of: KakaoUserResponse.self) { profileResponse in
                        switch profileResponse.result {
                        case .success(let user):
                            let nickname = user.kakao_account.profile.nickname
                            print("사용자 닉네임:", nickname)

                            let tokenInfo = TokenInfo(
                                accessToken: token.access_token,
                                refreshToken: token.refresh_token,
                                nickname: nickname
                            )
                            KeychainService.shared.saveToken(tokenInfo)
                            UserDefaults.standard.set(nickname, forKey: "nickname") //값을 저장/조회할 때 사용하는 이름표

                            print("UserDefaults 저장된 닉네임:", UserDefaults.standard.string(forKey: "nickname") ?? "nil")

                        case .failure(let error):
                            print("사용자 정보 요청 실패:", error)
                        }
                    }
            case .failure(let error):
                print("토큰 요청 실패:", error)
                if let data = response.data,
                   let body = String(data: data, encoding: .utf8) {
                    print("응답 본문:\n\(body)")
                }
            }
        }
}
