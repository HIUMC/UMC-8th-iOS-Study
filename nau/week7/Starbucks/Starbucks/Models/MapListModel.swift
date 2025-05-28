//
//  MapListModel.swift
//  Starbucks
//
//  Created by nau on 5/2/25.
//

import Foundation
import CoreLocation
import SwiftUI

struct MapListModel: Identifiable, Decodable {
    let id = UUID()
    let imageURL: URL? = nil // 구글 api로 사진 정보 받아오기
    let name: String
    let address: String
    let coordinate: CLLocationCoordinate2D
    let category: String
    var distance: Double?

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
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let props = try container.nestedContainer(keyedBy: PropertiesKeys.self, forKey: .properties)
        let geo = try container.nestedContainer(keyedBy: GeometryKeys.self, forKey: .geometry)

        let coords = try geo.decode([Double].self, forKey: .coordinates)

        name = try props.decode(String.self, forKey: .name)
        address = try props.decode(String.self, forKey: .address)
        category = try props.decodeIfPresent(String.self, forKey: .category) ?? ""
        coordinate = CLLocationCoordinate2D(latitude: coords[1], longitude: coords[0])
    }
    
    init(name: String, address: String, coordinate: CLLocationCoordinate2D, category: String, distance: Double? = nil) {
        self.name = name
        self.address = address
        self.coordinate = coordinate
        self.category = category
        self.distance = distance
    }
}

