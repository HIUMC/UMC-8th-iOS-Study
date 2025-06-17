//
//  TokenResponse.swift
//  week7Project
//
//  Created by nau on 5/20/25.
//

import Foundation

struct TokenResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
