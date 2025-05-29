//
//  RouteViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/27/25.
//
import SwiftUI
import Foundation
import MapKit
import Moya


class RouteViewModel: ObservableObject {
    private let provider = MoyaProvider<OSRMAPI>()

    @Published var routeCoordinates: [CLLocationCoordinate2D] = []
    @Published var totalDistance: Double = 0
    @Published var totalDuration: Double = 0

    func findRoute(from start: CLLocationCoordinate2D, to end: CLLocationCoordinate2D) {
        provider.request(.route(start: start, end: end)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(OSRMRouteResponse.self, from: response.data)
                    if let route = decoded.routes.first {
                        self.totalDistance = route.distance
                        self.totalDuration = route.duration
                        self.routeCoordinates = route.geometry.coordinates.map {
                            CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])
                        }
                    }
                } catch {
                    print(" 경로 디코딩 실패: \(error)")
                }
            case .failure(let error):
                print(" OSRM 요청 실패: \(error)")
            }
        }
    }
}
