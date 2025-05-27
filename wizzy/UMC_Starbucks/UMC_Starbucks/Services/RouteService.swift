//
//  RouteService.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/20/25.
//

import Foundation
import Moya
import CoreLocation

class RouteService {
    private let provider = MoyaProvider<RouteAPI>()

    func fetchRoute(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, profile: OSRMProfile, completion: @escaping (RouteData?) -> Void) {
        provider.request(.route(start: start, end: end, profile: profile)) { result in
            switch result {
            case let .success(response):
                do {
                    let decoded = try JSONDecoder().decode(RouteResponse.self, from: response.data)
                    completion(decoded.routes.first)
                } catch {
                    print("디코딩 실패:", error)
                    completion(nil)
                }

            case let .failure(error):
                print("요청 실패:", error)
                completion(nil)
            }
        }
    }
}
