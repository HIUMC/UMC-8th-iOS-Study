//
//  LoginModel.swift
//  Starbucks
//
//  Created by 박정환 on 5/12/25.
//

import Foundation

struct LoginModel {
    
    // MARK: - 로그인 응답 처리
    struct LoginResponse {
        let code: String?
        let error: String?
        let errorDescription: String?
        
        // 성공적인 로그인 응답 처리
        init(url: URL) {
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            let queryItems = components?.queryItems
            
            // code 값 가져오기 (로그인 성공)
            self.code = queryItems?.first(where: { $0.name == "code" })?.value
            
            // error 값 가져오기 (로그인 실패)
            self.error = queryItems?.first(where: { $0.name == "error" })?.value
            self.errorDescription = queryItems?.first(where: { $0.name == "error_description" })?.value
        }
        
        // 로그인 성공 체크
        func isSuccess() -> Bool {
            return code != nil
        }
        
        // 로그인 실패 체크
        func isFailure() -> Bool {
            return error != nil
        }
    }
    
    // MARK: - 카카오 로그인 처리
    func handleLoginResponse(url: URL) -> LoginResponse {
        return LoginResponse(url: url)
    }
}
