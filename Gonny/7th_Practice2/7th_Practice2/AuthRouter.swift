//
//  AuthRouter.swift
//  7th_Practice2
//
//  Created by 박병선 on 5/20/25.
//
import Foundation
import Moya

enum AuthRouter {
    case sendRefreshToken(refreshToken: String) // 리프레시 토큰 갱신
}

extension AuthRouter: APITargetType {
    var path: String {
        switch self {
        case .sendRefreshToken:
            return "/member/reissue"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .sendRefreshToken:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .sendRefreshToken:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .sendRefreshToken(let refresh):
            var headers = ["Content-Type": "application/json"]
            headers["Refresh-Token"] = "\(refresh)"
            
            return headers
        }
    }
}

