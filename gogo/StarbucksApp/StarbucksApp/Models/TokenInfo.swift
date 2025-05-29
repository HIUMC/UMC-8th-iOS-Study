//
//  TokenInfo.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/28/25.
//

import Foundation

struct TokenInfo: Codable {
    let accessToken: String
    let refreshToken: String
    let nickname: String
}
