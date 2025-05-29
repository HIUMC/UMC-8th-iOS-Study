//
//  KakaoTargetType.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/27/25.
//

import Foundation
import Moya

enum KakaoLocalAPI {
    case searchKeyword(query: String, x: Double? = nil, y: Double? = nil, radius: Int? = nil, page: Int = 1, size: Int = 15, sort: String = "accuracy")
}


extension KakaoLocalAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }

    var path: String {
        switch self {
        case .searchKeyword:
            return "/v2/local/search/keyword.json"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case let .searchKeyword(query, x, y, radius, page, size, sort):
            var params: [String: Any] = [
                "query": query,
                "page": page,
                "size": size,
                "sort": sort
            ]
            if let x = x, let y = y {
                params["x"] = x
                params["y"] = y
            }
            if let radius = radius {
                params["radius"] = radius
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        guard let apiKey = Bundle.main.infoDictionary?["KAKAO_REST_API_KEY"] as? String else {
            fatalError("❌ Kakao API 키 누락")
        }
        return [
            "Authorization": "KakaoAK \(apiKey)"
        ]
    }

    var sampleData: Data {
        return Data()
    }
}
