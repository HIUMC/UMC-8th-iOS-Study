//
//  StoreModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 5/1/25.
//

import Foundation
import SwiftUI

struct GeoJSON: Decodable {
    let type: String
    let name: String
    let features: [Feature]
}

struct Feature: Decodable {
    let type: String
    let properties: StoreModel
}


struct StoreModel: Codable, Identifiable {
    let id = UUID()
    
    let storeName: String
    let address: String
    let category: String
    let xCoordinate: Double
    let yCoordinate: Double
    
    enum CodingKeys: String, CodingKey {
        case storeName = "Sotre_nm"
        case address = "Address"
        case category = "Category"
        case xCoordinate = "Xcoordinate"
        case yCoordinate = "Ycoordinate"
    }
}
