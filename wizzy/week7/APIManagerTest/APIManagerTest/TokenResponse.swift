//
//  TokenResponse.swift
//  APIManagerTest
//
//  Created by 이서현 on 5/19/25.
//

import Foundation

struct TokenResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: UserInfo
}
