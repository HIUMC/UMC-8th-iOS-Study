//
//  DirectionsRouter.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/19/25.
//
//Moya로 OSRM 경로 응답 모델
//아이피 설정 

import Foundation
import Moya
import CoreLocation

enum DirectionsRouter {
    case route(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D)
}

extension DirectionsRouter: TargetType {
    var baseURL: URL {
        return URL(string: "http://175.118.225.161:8080")!
        //와이파이 바꾸면 이거도 바꿔야 함
    }

    var path: String {
        switch self {
        case let .route(start, end):
            // 경도, 위도 순서 // 경로요청
            return "/route/v1/foot/\(start.longitude),\(start.latitude);\(end.longitude),\(end.latitude)"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestParameters(
            parameters: [
                "overview": "full",  //전체경로
                "geometries": "geojson"
            ],
            encoding: URLEncoding.queryString
        )
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }
}
