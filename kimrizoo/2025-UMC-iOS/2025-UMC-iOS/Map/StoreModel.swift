import Foundation
import CoreLocation

// MARK: - Root 모델
struct StoreFeatureCollection: Codable {
    let features: [StoreFeature]
}

// MARK: - 매장 Feature
struct StoreFeature: Codable {
    let properties: StoreProperties
    let geometry: StoreGeometry
}

// MARK: - 매장 속성
struct StoreProperties: Codable {
    let seq: String
    let name: String
    let address: String
    let telephone: String
    let category: String
    let yCoordinate: Double
    let xCoordinate: Double

    enum CodingKeys: String, CodingKey {
        case seq = "Seq"
        case name = "Sotre_nm"
        case address = "Address"
        case telephone = "Telephone"
        case category = "Category"
        case yCoordinate = "Ycoordinate"
        case xCoordinate = "Xcoordinate"
    }
}

// MARK: - 위치 정보
struct StoreGeometry: Codable {
    let coordinates: [Double]
}
