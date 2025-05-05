//
//  SignupModel.swift
//  Starbucks
//
//  Created by 박정환 on 3/29/25.
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
