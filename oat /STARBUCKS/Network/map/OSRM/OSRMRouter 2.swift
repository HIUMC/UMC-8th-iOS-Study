//
//  OSRMRouter.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/22/25.
//

import Moya
import Foundation


enum OSRMRouter {
    case route(start: String, end: String)
}

extension OSRMRouter: TargetType {
    
    var baseURL: URL {
        if let urlString = Bundle.main.infoDictionary?["OSRM_BASE_URL"] as? String,
           let url = URL(string: urlString) {
            return url
        } else {
            fatalError("❌ OSRM_BASE_URL 누락 또는 URL 형식 오류: Info.plist 또는 .xcconfig 설정 확인 필요")
        }
    }


    var path: String {
        switch self {
        case .route(let start, let end):
            return "/route/v1/foot/\(start);\(end)"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        // 쿼리 파라미터 직접 추가 가능
        let parameters: [String: Any] = [
            "overview": "full",
            "geometries": "geojson"
        ]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data() // 테스트용
    }
}
