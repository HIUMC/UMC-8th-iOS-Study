//
//  ServiceManager.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/17/25.
//

import Foundation
import Alamofire

struct OAuthTokenResponse: Codable {
  let accessToken: String
  let refreshToken: String
  enum CodingKeys: String, CodingKey {
    case accessToken  = "access_token"
    case refreshToken = "refresh_token"
  }
}

final class ServiceManager {
  static let shared = ServiceManager()
  private init() {}


  func requestKakaoToken(
    code: String,
    restAPIKey: String,
    redirectURI: String,
    completion: @escaping (Result<OAuthTokenResponse, AFError>) -> Void
  ) {
    let params: [String: String] = [
      "grant_type":   "authorization_code",
      "client_id":    restAPIKey,
      "redirect_uri": redirectURI,
      "code":         code
    ]

    AF.request(
      "https://kauth.kakao.com/oauth/token",
      method: .post,
      parameters: params,
      encoder: URLEncodedFormParameterEncoder.default
    )
    .responseDecodable(of: OAuthTokenResponse.self) { resp in
      completion(resp.result)   
    }
  }
}
