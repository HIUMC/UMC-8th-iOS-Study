//
//  KakaoTokenResponse.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/21/25.
//
//응답보고 만든 모델!
import Foundation

struct KakaoTokenResponse: Codable {
    let tokenType: String
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String
    let refreshTokenExpiresIn: Int

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshTokenExpiresIn = "refresh_token_expires_in"
    }
}
