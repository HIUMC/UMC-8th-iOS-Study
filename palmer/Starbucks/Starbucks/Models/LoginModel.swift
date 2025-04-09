//
//  LoginModel.swift
//  1st_work
//
//  Created by 박정환 on 3/22/25.
//

import Foundation

// 사용자 로그인 정보를 담당하는 모델
struct LoginModel {
    var id: String
    var pwd: String
    
    // 초기화 메서드
    init(id: String, pwd: String) {
        self.id = id
        self.pwd = pwd
    }
    
    // 로그인 정보가 유효한지 확인하는 메서드 (예시로 id와 pwd가 모두 비어있지 않으면 유효하다고 판단)
    func isValid() -> Bool {
        return !id.isEmpty && !pwd.isEmpty
    }
}
