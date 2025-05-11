//
//  TokenAuthenticator.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/10/25.
//


import Foundation

class TokenAuthenticator {
    
    static let shared = TokenAuthenticator()
    
    private let tokenService = "com.starbucks.token"
    private let tokenAccount = "accessToken"
    
    private init() {}
    
}
