//
//  MapListModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/3/25.
//

import Foundation
import CoreLocation
import SwiftUI

struct MapListModel: Identifiable, Decodable {
    let id = UUID()
    let image: ImageResource
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let category: String
    var distance: Double?

    // ✅ 추가된 부분
    let photoReference: String?

    enum CodingKeys: String, CodingKey {
        case geometry, properties
    }

    enum GeometryKeys: String, CodingKey {
        case coordinates
    }

    enum PropertiesKeys: String, CodingKey {
        case name = "Sotre_nm"
        case address = "Address"
        case category = "Category"
        case photoReference = "PhotoReference" // ✅ 여기가 JSON 키랑 맞아야 함
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let props = try container.nestedContainer(keyedBy: PropertiesKeys.self, forKey: .properties)
        let geo = try container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)

        let coords = try geo.decode([Double].self, forKey: .coordinates)

        image = ImageResource(name: "c1", bundle: .main)
        name = try props.decode(String.self, forKey: .name)
        address = try props.decode(String.self, forKey: .address)
        category = try props.decodeIfPresent(String.self, forKey: .category) ?? ""
        photoReference = try props.decodeIfPresent(String.self, forKey: .photoReference) // ✅ 여기만 추가
        coordinate = CLLocationCoordinate2D(latitude: coords[1], longitude: coords[0])
    }

    init(image: ImageResource, name: String, address: String, coordinate: CLLocationCoordinate2D, category: String, distance: Double? = nil, photoReference: String? = nil) {
        self.image = image
        self.name = name
        self.address = address
        self.coordinate = coordinate
        self.category = category
        self.distance = distance
        self.photoReference = photoReference // ✅ 여기도 같이 추가
    }
}

struct FeatureCollection: Decodable {
    let features: [MapListModel]
}
