//
//  TokenResponse.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/28/25.
//
//


import Foundation

struct TokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let refresh_token: String
    let expires_in: Int
}
