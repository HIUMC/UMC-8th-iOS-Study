//
//  TokenInfo.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/12/25.
//

import Foundation

struct TokenInfo: Codable {
    let accessToken: String
    let refreshToken: String
}

struct KakaoTokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let expiresIn: Int
    let refreshTokenExpiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresIn = "expires_in"
        case refreshTokenExpiresIn = "refresh_token_expires_in"
    }
}
