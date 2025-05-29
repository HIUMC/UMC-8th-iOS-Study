//
//  TokenResponse.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/19/25.
//

import Foundation

struct TokenResponse: Decodable {
    let access_token: String
    let token_type: String
    let refresh_token: String
    let expires_in: Int
}
