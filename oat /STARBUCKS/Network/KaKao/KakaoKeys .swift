//
//  KakaoKeys .swift
//  STARBUCKS
//
//  Created by 신민정 on 5/21/25.
//

import Foundation

enum KakaoKeys {
    static let restAPIKey: String = Bundle.main.infoDictionary?["KAKAO_REST_API_KEY"] as? String ?? ""
    static let redirectURI: String = Bundle.main.infoDictionary?["KAKAO_REDIRECT_URI"] as? String ?? ""
}
