//
//  Config.swift
//  UMC-iOS-WorkBook-6-Alamofire
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
    
    static let baseURL: String = {
        guard let baseURL = Config.infoDictionary["API_URL"] as? String else {
            fatalError()
        }
        return baseURL
    }()
    
    static let imageURL: String = {
        guard let baseURL = Config.infoDictionary["Image_URL"] as? String else {
            fatalError()
        }
        return baseURL
    }()
}
