//
//  TokenModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/12/25.
//

import Foundation

struct TokenInfo: Codable {
    let accessToken: String
    let refreshToken: String
    let nickname: String
}
