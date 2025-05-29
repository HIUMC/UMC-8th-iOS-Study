//
//  RouteResponse.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/20/25.
//

import Foundation

struct RouteResponse: Codable {
    let routes: [RouteData]
    let waypoints: [Waypoint]
}

struct RouteData: Codable {
    let geometry: Geometry
    let distance: Double
    let duration: Double
}

struct Geometry: Codable {
    let coordinates: [[Double]]
    let type: String
}

struct Waypoint: Codable {
    let location: [Double]
    let name: String
}
