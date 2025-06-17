//
//  TokenResponse.swift
//  week8Lab
//
//  Created by tokkislove on 6/17/25.
//

import Foundation

struct TokenResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
