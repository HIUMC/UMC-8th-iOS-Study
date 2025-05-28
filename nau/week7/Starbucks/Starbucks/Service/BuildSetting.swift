//
//  BuildSetting.swift
//  Starbucks
//
//  Created by nau on 5/22/25.
//

import Foundation

enum BuildSetting {
    static let kakaoAppKey: String = {
        guard let key = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String else {
            fatalError("kakao native app key 오류")
        }
        return key
    }()
    
    static let kakaoRestApiKey: String = {
        guard let key = Bundle.main.infoDictionary?["KAKAO_REST_API_KEY"] as? String else {
            fatalError("kakao rest api key 오류")
        }
        return key
    }()
    
    static let googleApiKey: String = {
        guard let key = Bundle.main.infoDictionary?["GOOGLE_API_KEY"] as? String else {
            fatalError("google api key 오류")
        }
        return key
    }()
    
    static let baseUrl: String = {
        guard let key = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            fatalError("base url 오류")
        }
        return key
    }()
}
