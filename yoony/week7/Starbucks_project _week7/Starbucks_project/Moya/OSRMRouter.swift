//
//  OSRMRouter.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/22/25.
//

import Foundation
import Moya

enum OSRMRouter {
    case route(start: (Double, Double), end: (Double, Double))  // 경도, 위도
}

extension OSRMRouter: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://localhost:8080")! // 실제 배포 시 ngrok 주소로 교체 가능
    }

    var path: String {
        switch self {
        case .route(let start, let end):
            return "/route/v1/driving/\(start.0),\(start.1);\(end.0),\(end.1)"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        // overview=full, geometries=polyline 등 OSRM API 기본 옵션
        return .requestParameters(parameters: [
            "overview": "full",
            "geometries": "polyline"
        ], encoding: URLEncoding.queryString)
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        let json = """
        {
          "code": "Ok",
          "routes": [{
            "geometry": "mehdF_n_fWj@sCfAl@zA_...",
            "distance": 9380.8,
            "duration": 6766.2,
            "legs": []
          }],
          "waypoints": []
        }
        """
        return Data(json.utf8)
    }
}
