//
//  RouteAPI.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/20/25.
//

import Foundation
import Moya
import CoreLocation

enum OSRMProfile: String {
    case driving
    case foot
    case bike
}

enum RouteAPI {
    case route(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, profile: OSRMProfile)
}

extension RouteAPI: TargetType {
    
    var baseURL: URL {
        let urlString = Bundle.main.object(forInfoDictionaryKey: "OSRM_BASE_URL") as? String ?? ""
        return URL(string: urlString)!
    }
    
    var path: String {
        switch self {
        case let .route(start, end, profile):
            return "/route/v1/\(profile.rawValue)/\(start.longitude),\(start.latitude);\(end.longitude),\(end.latitude)"
        }
    }
    
    var method: Moya.Method { .get }
    
    var task: Task {
        return .requestParameters(
            parameters: ["geometries": "geojson"],
            encoding: URLEncoding.queryString
        )
    }
    
    var headers: [String : String]? { nil }
    
    var sampleData: Data {
        return Data()
    }
}
