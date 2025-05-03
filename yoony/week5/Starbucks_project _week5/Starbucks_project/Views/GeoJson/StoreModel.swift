//
//  GeoJsonModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/3/25.
//

import Foundation

// 전체 JSON 구조를 나타내는 타입
struct StoreData: Codable {
    var type: String
    var features: [StoreFeature]  // 각 매장을 나타내는 타입
}

// 매장 하나를 나타내는 타입
struct StoreFeature: Codable, Identifiable {
    var id: String { return properties.storeName }
    
    var type: String
    var properties: StoreProperties  // 매장의 세부 정보
    var geometry: StoreGeometry      // 위치 정보
}

// 매장의 세부 정보 (이름, 주소, 카테고리 등)
struct StoreProperties: Codable {
    var storeName: String
    var address: String
    var telephone: String
    var category: String
    var xcoordinate: Double
    var ycoordinate: Double
    var type: String
}

// 위치 정보 (위도, 경도)
struct StoreGeometry: Codable {
    var type: String
    var coordinates: [Double]  // [longitude, latitude]
}
