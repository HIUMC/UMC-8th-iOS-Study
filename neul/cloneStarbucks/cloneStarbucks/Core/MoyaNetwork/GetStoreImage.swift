//
//  GetStoreImage.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/23/25.
//

import Foundation
import Moya

enum GetStoreImage {
    case getStoreInfo(query: String)
    case storeImage(imageUrl: String)
}



extension GetStoreImage: APITargetType {
    var baseURL: URL {
        switch self {
        case .getStoreInfo, .storeImage:
            guard let baseURL = URL(string: "https://maps.googleapis.com") else { fatalError("Error: Invalid URL") }
            return baseURL
        }
    }
    
    var path: String {
        switch self {
        case .getStoreInfo:
            return "/maps/api/place/textsearch/json"
        case .storeImage:
            return "/maps/api/place/photo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getStoreInfo, .storeImage:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getStoreInfo(let query):
            let parameters: [String: Any] = [
                "query": query,
                "radius": 10000,
                "language": "ko",
                "region": "kr",
                "type": "cafe",
                "key": Config.googleApiKey
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .storeImage(let imageUrl):
            let parameters: [String: Any] = [
                "photo_reference": imageUrl,
                "maxWidth": 400,
                "key": Config.googleApiKey
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
}
