//
//  FindRoute.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/20/25.
//

import Foundation
import Moya

enum FindRoute {
    case keywordSearch(query: String)
    
}

extension FindRoute : APITargetType {
    var baseURL: URL {
        switch self {
        case .keywordSearch:
            guard let baseURL = URL(string: "https://dapi.kakao.com") else { fatalError("Error: Invalid URL") }
            return baseURL
        }
    }
    
    var path: String {
        switch self {
        case .keywordSearch:
            return "/v2/local/search/keyword.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .keywordSearch:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .keywordSearch(let query):
            let parameters: [String: Any] = [
                "query": query,
                "radius": 5,
                "page": 1,
                "size": 15
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
