//
//  MyModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/3/25.
//

import Foundation

struct GeoJSONFile: Codable {
    let type: String
    let features: [Feature]
}

struct Feature: Codable {
    let type: String
    let geometry: Geometry
    let properties: MyModel

    struct Geometry: Codable {
        let type: String
        let coordinates: [Double]
    }
}

struct MyModel: Codable {
    let seq: String
    let address: String
    let telephone: String
    let storeName: String
    let category: String
    let ycoordinate: Double
    let xcoordinate: Double
    
    enum CodingKeys: String, CodingKey {
        case seq = "Seq"
        case address = "Address"
        case telephone = "Telephone"
        case storeName = "Sotre_nm"
        case category = "Category"
        case ycoordinate = "Ycoordinate"
        case xcoordinate = "Xcoordinate"
        
    }
}

/*
 {
 "type": "Feature",
 "properties": {
 "Seq": "1.0",
 "Sotre_nm": "신림사거리",
 "Address": "서울특별시 관악구 남부순환로 1619 (신림동)",
 "Telephone": "1522-3232",
 "Category": "",
 "Ycoordinate": 37.484768,
 "Xcoordinate": 126.930467
 }
 */
