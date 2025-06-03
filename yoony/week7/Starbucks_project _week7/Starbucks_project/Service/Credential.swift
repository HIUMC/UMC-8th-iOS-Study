//
//  Credential.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/11/25.
//

import Foundation
import SwiftUI
import Alamofire

struct Credential: AuthenticationCredential {
    let accessToken: String
    let expiration: Date
    
    // 토큰이 만료되기 전에 판단하여 x분 전에 갱신해야 됩니다.
    // 아래 코드는 5분으로 두어, 5분전에 갱신 되도록 했습니다.
    var requiresRefresh: Bool {
        return Date(timeIntervalSinceNow: 60 * 5) > expiration
    }
}
