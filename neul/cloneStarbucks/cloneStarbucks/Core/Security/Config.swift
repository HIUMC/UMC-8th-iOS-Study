//
//  Config.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/12/25.
//

import Foundation

enum Config {
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist 없음")
        }
        return dict
    }()
    
    static let nativeAppKey: String = {
        guard let nativeAppKey = Config.infoDictionary["NATIVE_APP_KEY"] as? String else {
            fatalError()
        }
        return nativeAppKey
    }()
    
    static let restApiKey: String = {
        guard let restApiKey = Config.infoDictionary["REST_API_KEY"] as? String else {
            fatalError()
        }
        return restApiKey
    }()
    

}
