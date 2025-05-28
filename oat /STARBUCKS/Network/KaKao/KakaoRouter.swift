//
//  KakaoRouter.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/19/25.
//

import Foundation
import Moya

enum KakaoRouter {
    case keywordSearch(query: String)
}

extension KakaoRouter: TargetType {
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }

    var path: String {
        switch self {
        case .keywordSearch:
            return "/v2/local/search/keyword.json"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .keywordSearch(let query):
            return .requestParameters(
                parameters: ["query": query],
                encoding: URLEncoding.default
            )
        }
    }

    var headers: [String: String]? {
      let key = Bundle.main.infoDictionary?["KAKAO_REST_API_KEY"] as? String ?? ""
      return ["Authorization": "KakaoAK \(key)"]
    }


    var sampleData: Data {
        return Data() // 테스트용
    }
}

