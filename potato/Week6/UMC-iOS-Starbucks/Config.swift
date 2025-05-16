//
//  Config.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 5/13/25.
//

import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 없음")
        }
        return dict
    }()
    
    static let kakaoLoginURL: String = {
        guard let kakaoLoginURL = Config.infoDictionary["API_URL"] as? String else {
            fatalError()
        }
        return kakaoLoginURL
    }()
    
    static let kakaoSecretKey: String = {
        guard let kakaoSecretKey = Config.infoDictionary["NATIVE_APP_KEY"] as? String else {
            fatalError()
        }
        return kakaoSecretKey
    }()
}
