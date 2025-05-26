//
//  StarbuckStoreModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/29/25.
//
import Foundation
import CoreLocation

struct StarbuckStoreModel: Codable {
    var features: [StoreFeature]
}

struct StoreFeature: Codable, Hashable {
    var properties: StoreProperty
    let geometry: Geometry
}

struct StoreProperty: Codable, Hashable, Identifiable {
    var id: String { storeId }
    
    let storeId: String
    let storeName: String
    let address: String
    let telephone: String
    let category: StoreCategory
    let yCoordinate: Double
    let xCoordinate: Double
    
    var resolvedAddress: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case storeId = "Seq"
        case storeName = "Sotre_nm"
        case address = "Address"
        case telephone = "Telephone"
        case category = "Category"
        case yCoordinate = "Ycoordinate"
        case xCoordinate = "Xcoordinate"
    }
}

struct Geometry: Codable, Hashable {
    let type: String
    let coordinates: [Double]
}


enum StoreCategory: String, Codable {
    case none = ""
    case reserve = "리저브 매장"
    case dt = "DT 매장"
}


struct Marker: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}



// MARK: - 실제 list에 띄울 모델
struct StarbucksImageModel: Hashable {
    let storeName: String
    let address: String
    let distance: CLLocationDistance
    let category: StoreCategory
    var imageData: String?
}
