//
//  Config.swift
//  UMC-iOS-WorkBook-6-Practice
//
//  Created by 곽은채 on 5/12/25.
//

import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 없음")
        }
        return dict
    }()
    
    static let apiKey: String = {
        guard let baseURL = Config.infoDictionary["API_Key"] as? String else {
            fatalError()
        }
        return baseURL
    }()

}
