//
//  OSRMAPI.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/27/25.
//
import Foundation
import Moya
import CoreLocation

enum OSRMAPI {
    case route(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D)
}

extension OSRMAPI: TargetType {
    var baseURL: URL {
        // Xcconfig에서 불러오거나 직접 작성
        return URL(string: Bundle.main.infoDictionary?["OSRM_BASE_URL"] as? String ?? "http://localhost:8080")!
    }

    var path: String {
        switch self {
        case .route(let start, let end):
            return "/route/v1/driving/\(start.longitude),\(start.latitude);\(end.longitude),\(end.latitude)"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .route:
            return .requestParameters(parameters: [
                "overview": "full",
                "geometries": "geojson"
            ], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        // 실제 데이터 구조는 경로의 geometry와 coordinates 배열
        let sampleJSON = """
        {
            "routes": [
                {
                    "geometry": {
                        "coordinates": [
                            [127.1, 37.5],
                            [127.15, 37.55],
                            [127.2, 37.6]
                        ],
                        "type": "LineString"
                    },
                    "legs": [],
                    "weight_name": "routability",
                    "weight": 150.2,
                    "duration": 120.5,
                    "distance": 3020.1
                }
            ],
            "waypoints": []
        }
        """
        return Data(sampleJSON.utf8)
    }
}
