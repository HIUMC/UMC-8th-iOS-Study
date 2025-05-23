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
    case addressToCoordinate(add: String)
    case osrmRoute(source: (Double, Double), dest: (Double, Double))
}


extension FindRoute : APITargetType {
    var baseURL: URL {
        switch self {
        case .keywordSearch, .addressToCoordinate:
            guard let baseURL = URL(string: "https://dapi.kakao.com") else { fatalError("Error: Invalid URL") }
            return baseURL
        case .osrmRoute:
            guard let baseURL = URL(string: Config.baseUrl) else { fatalError("Error: Invalid URL") }
            return baseURL
        }
    }
    
    var path: String {
        switch self {
        case .keywordSearch:
            return "/v2/local/search/keyword.json"
        case .addressToCoordinate:
            return "/v2/local/search/address.json"
        case .osrmRoute(let source, let dest):
            return "/route/v1/foot/\(source.0),\(source.1);\(dest.0),\(dest.1)?geometries=geojson"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .keywordSearch, .addressToCoordinate, .osrmRoute:
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
            
        case .addressToCoordinate(let add):
            return .requestParameters(parameters: ["query": add], encoding: URLEncoding.queryString)
            
        case .osrmRoute:
            return .requestPlain
        }
    }
}
