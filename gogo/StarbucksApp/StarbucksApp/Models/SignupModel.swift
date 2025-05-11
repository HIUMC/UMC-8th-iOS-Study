//
//  SignupModel.swift
//  Starbucks_Week1_gogo
//
//  Created by 고석현 on 4/1/25.
//

import Foundation
import SwiftUI

// 사용자 로그인 정보를 담당하는 모델
struct SignupModel {
    var id: String
    var password: String
    var nickname: String
    
    // 초기화 메서드
    init(id: String, password: String, nickname: String) {
        self.id = id
        self.password = password
        self.nickname = nickname
    }
}
