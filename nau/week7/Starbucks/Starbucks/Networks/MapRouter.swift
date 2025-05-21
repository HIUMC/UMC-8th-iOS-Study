//
//  MapRouter.swift
//  Starbucks
//
//  Created by nau on 5/20/25.
//

import Foundation
import Moya

enum MapRouter {
    case getOrsm(start: String, end: String)
    case getSearchAddress(query: String)
}

extension MapRouter : TargetType {
    var baseURL: URL {
        switch self {
        case .getOrsm:
            return URL(string: "http://localhost:8080")!
        case .getSearchAddress:
            return URL(string: "http://dapi.kakao.com")!
        }
    }
    
    var path: String {
        switch self {
        case .getOrsm(let start, end: let end):
            return "/route/v1/\(start);\(end)"
        case .getSearchAddress(query: let query):
            return "/v2/local/search/keyword.json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}

