//
//  MapRouter.swift
//  Starbucks
//
//  Created by nau on 5/20/25.
//

import Foundation
import Moya

enum MapRouter {
    case getOrsmRoute(start: String, end: String)
    case getSearchAddress(query: String)
    case getPhotoURL(query: String)
    case getPlaceId(query: String)
}

extension MapRouter : TargetType {
    var baseURL: URL {
        switch self {
        case .getOrsmRoute:
            return URL(string: "http://localhost:8080")!
        case .getSearchAddress:
            return URL(string: "https://dapi.kakao.com")!
        case .getPlaceId:
            return URL(string: "https://maps.googleapis.com/maps/api/place/findplacefromtext")!
        case .getPhotoURL:
            return URL(string: "https://maps.googleapis.com/maps/api/place/details")!
        }
    }
    
    var path: String {
        switch self {
        case .getOrsmRoute(let start, end: let end):
            return "/route/v1/foot-walking/\(start);\(end)"
        case .getSearchAddress:
            return "/v2/local/search/keyword.json"
        case .getPhotoURL, .getPlaceId:
            return "/json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .getOrsmRoute:
            return .requestPlain
        case .getSearchAddress(let query):
            let parameters: [String: Any] = [
                "query": query,
                "page": 1,
                "size": 15
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getPhotoURL(let query):
            let parameters: [String: Any] = [
                "place_id": query,
                "key": BuildSetting.googleApiKey
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .getPlaceId(query: let query):
            let parameters: [String: Any] = [
                "input": query,
                "inputtype": "textquery",
                "key": BuildSetting.googleApiKey
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .getOrsmRoute, .getPhotoURL, .getPlaceId:
            return ["Content-Type": "application/json"]
        case .getSearchAddress:
            return [
                "Authorization": "KakaoAK \(BuildSetting.kakaoRestApiKey)",
                "Content-Type": "application/json"
            ]
        }
    }
}

