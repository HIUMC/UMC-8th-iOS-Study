//
//  MapRouter.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/29/25.
//

// KakaoLocalAPI.swift

import Foundation
import Moya

enum MapRouter {
    case keywordSearch(query: String)
}

extension MapRouter: TargetType {
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }

    var path: String {
        return "/v2/local/search/keyword.json"
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .keywordSearch(let query):
            var params: [String: Any] = [
                "query": query,
                "page": 1,
                "size": 15,
                "radius": 5
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return ["Authorization": "KakaoAK \(String(describing: Bundle.main.infoDictionary?["KAKAO_REST_API_KEY"] as? String)) ?? "]
    }

    var sampleData: Data {
        return Data()
    }
}
