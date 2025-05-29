//
//  RouteModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/27/25.
//
//OSRM 디코딩용 응답 모델
import Foundation

struct RouteResponse: Codable {
    let routes: [Route]
}

struct Route: Codable {
    let geometry: RouteGeometry
    let distance: Double
    let duration: Double
}

struct RouteGeometry: Codable {
    let coordinates: [[Double]]  // [longitude, latitude] 순서
    let type: String
}

//예시사용
/*
let decoded = try JSONDecoder().decode(RouteResponse.self, from: response.data)
let path: [CLLocationCoordinate2D] = decoded.routes.first?.geometry.coordinates.map {
    CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])
} ?? []
*/

