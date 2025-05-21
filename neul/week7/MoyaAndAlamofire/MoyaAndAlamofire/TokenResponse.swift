//
//  TokenResponse.swift
//  MoyaAndAlamofire
//
//  Created by tokkislove on 5/20/25.
//


import Foundation

struct TokenResponse: Codable {
    var accessToken: String
    var refreshToken: String
}
