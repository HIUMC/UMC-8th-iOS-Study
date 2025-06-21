//
//  SignupModel.swift
//  Starbucks
//
//  Created by 박정환 on 3/29/25.
//

import Foundation
import SwiftUI

// 사용자 로그인 정보를 담당하는 모델
struct SignupModel: Codable {
    var nickname: String
    var email: String
    var password: String
}
