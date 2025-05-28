//
//  OSRMRouter.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/20/25.
//

import Foundation
import Moya
import CoreLocation

enum OSRMRouter {
    case route(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D)
}

extension OSRMRouter: TargetType {
    var baseURL: URL {
        return URL(string: "http://192.168.0.6:8080")!
    }

    var path: String {
        switch self {
        case let .route(start, end):
            return "/route/v1/foot/\(start.longitude),\(start.latitude);\(end.longitude),\(end.latitude)"
        }
    }

    var method: Moya.Method { .get }

    var task: Task {
        return .requestParameters(parameters: [
            "overview": "full",
            "geometries": "geojson"
        ], encoding: URLEncoding.queryString)
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }
}

