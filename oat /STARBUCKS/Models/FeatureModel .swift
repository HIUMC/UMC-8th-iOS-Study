//
//  FeatureModel .swift
//  STARBUCKS
//
//  Created by 신민정 on 4/28/25.
//
import Foundation


struct FeatureCollection: Decodable {
    let features: [Feature]
}

struct Feature: Decodable {
    let properties: StoreProperties
}

struct StoreProperties: Decodable {
    let name: String
    let address: String
    let category: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case name = "Sotre_nm"
        case address = "Address"
        case category = "Category"
        case latitude = "Ycoordinate"
        case longitude = "Xcoordinate"
    }
}
