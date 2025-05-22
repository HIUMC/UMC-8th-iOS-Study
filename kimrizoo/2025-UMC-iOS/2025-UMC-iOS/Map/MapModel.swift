import Foundation
import CoreLocation

// 최상위 구조
struct StoreFeatureCollection: Codable {
    let type: String
    let name: String
    let features: [StoreFeature]
}

// 각 매장 정보
struct StoreFeature: Codable {
    let type: String
    let properties: StoreProperties
    let geometry: Geometry
}

// 매장 속성 (이름, 주소 등)
struct StoreProperties: Codable {
    let seq: String
    let storeName: String
    let address: String
    let telephone: String
    let category: String
    let yCoordinate: Double
    let xCoordinate: Double

    // 키 매핑
    enum CodingKeys: String, CodingKey {
        case seq = "Seq"
        case storeName = "Sotre_nm"
        case address = "Address"
        case telephone = "Telephone"
        case category = "Category"
        case yCoordinate = "Ycoordinate"
        case xCoordinate = "Xcoordinate"
    }

    // 태그용 computed property
    var categoryTag: StoreCategoryTag {
        return StoreCategoryTag(category: category)
    }
}

// 위치 정보
struct Geometry: Codable {
    let type: String
    let coordinates: [Double]  // [longitude, latitude]
}

// Enum 정의
enum StoreCategoryTag: String {
    case reserve = "리저브"
    case driveThru = "DT"
    case none

    init(category: String) {
        if category.contains("리저브") {
            self = .reserve
        } else if category.contains("DT") {
            self = .driveThru
        } else {
            self = .none
        }
    }

    var tagSymbol: String {
        switch self {
        case .reserve:
            return "R"
        case .driveThru:
            return "D"
        case .none:
            return ""
        }
    }
}

struct StoreDisplayInfo: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let distance: String
    let tagSymbol: [String]  // "R", "D", ""
    let address: String
}

