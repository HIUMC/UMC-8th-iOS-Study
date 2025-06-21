//
//  Config.swift
//  StarbuckApp
//
//  Created by 박병선 on 6/20/25.
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
        guard let imageURL = Config.infoDictionary["Image_URL"] as? String else {
            fatalError()
        }
        return imageURL
    }()
}
