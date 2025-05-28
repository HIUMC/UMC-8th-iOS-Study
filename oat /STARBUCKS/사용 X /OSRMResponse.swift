//
//  OSRMResponse.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/20/25.
//OSRM 경로 응답 모델 

import Foundation

struct OSRMResponse: Decodable {
    let routes: [OSRMRoute]
}

struct OSRMRoute: Decodable {
    let geometry: OSRMGeometry
    let distance: Double
    let duration: Double
}

struct OSRMGeometry: Decodable {
    let coordinates: [[Double]]
}
