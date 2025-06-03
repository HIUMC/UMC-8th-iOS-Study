//
//  TokenResponse.swift
//  7st_Practice
//
//  Created by 김영택 on 5/22/25.
//

import Foundation

struct TokenResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
