//
//  GeoJSONRoute.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/22/25.
//
//OSRM 서버가 보낸 JSON 데이터를 -> Swift가 알아볼 수 있는 Swift 구조체로 변환

import Foundation

struct GeoJSONRoute: Codable {
    let routes: [Route]

    struct Route: Codable {
        let geometry: Geometry
    }

    struct Geometry: Codable {
        let coordinates: [[Double]]
        let type: String
    }
}
