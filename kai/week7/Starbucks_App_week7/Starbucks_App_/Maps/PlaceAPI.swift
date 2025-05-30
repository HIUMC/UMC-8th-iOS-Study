//
//  PlaceAPI.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/29/25.
//

import Moya
import Foundation

enum PlaceAPI {
    case searchPlaces(keyword: String)
}

extension PlaceAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }

    var path: String {
        switch self {
        case .searchPlaces:
            return "/v2/local/search/keyword.json"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .searchPlaces(let keyword):
            return .requestParameters(parameters: ["query": keyword], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        return [
            "Authorization": "KakaoAK {KAKAO_NATIVE_APP_KEY}",
            "Content-Type": "application/json"
        ]
    }

    var sampleData: Data {
        return Data()
    }
}

//리스폰스 만들기: 받는 틀을 만들기
