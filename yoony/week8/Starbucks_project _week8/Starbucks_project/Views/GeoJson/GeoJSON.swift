//
//  GeoJSON.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/3/25.
//

import Foundation
import CoreLocation
import SwiftUI

struct GeoJSON: Codable {
    let features: [Features]
}

struct Features: Codable {
    let properties: Properties
    let geometry: Geometry
    
    func toStore() -> MapListModel {
        return MapListModel(
            image: ImageResource(name: "c1", bundle: .main),
            name: properties.storeName,
            address: properties.address,
            coordinate: CLLocationCoordinate2D(latitude: properties.latitude, longitude: properties.longitude),
            category: properties.category
        )
    }
    
    struct Properties: Codable {
        let storeName: String
        let address: String
        let telephone: String
        let category: String
        let latitude: Double
        let longitude: Double
        
        enum CodingKeys: String, CodingKey {
            case storeName = "Sotre_nm"
            case address = "Address"
            case telephone = "Telephone"
            case category = "Category"
            case latitude = "Ycoordinate"
            case longitude = "Xcoordinate"
        }
    }
    
    struct Geometry: Codable {
        let coordinates: [Double]
    }
}
