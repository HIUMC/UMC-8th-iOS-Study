//
//  TokenResponse.swift
//  week7_practice
//
//  Created by 김지우 on 5/22/25.
//

import Foundation

struct TokenResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
