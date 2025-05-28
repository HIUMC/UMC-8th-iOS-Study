//
//  TokenResponse.swift
//  7th_Practice2
//
//  Created by 박병선 on 5/20/25.
//
import Foundation

struct TokenResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: UserInfo
}
