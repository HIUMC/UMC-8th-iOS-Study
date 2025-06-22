//
//  TokenResponse.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/22/25.
//

import Foundation

struct TokenResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
