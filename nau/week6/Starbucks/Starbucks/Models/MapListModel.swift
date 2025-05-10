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
    let image: ImageResource
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

        image = ImageResource(name: "coffeeDetail1", bundle: .main)
        name = try props.decode(String.self, forKey: .name)
        address = try props.decode(String.self, forKey: .address)
        category = try props.decodeIfPresent(String.self, forKey: .category) ?? ""
        coordinate = CLLocationCoordinate2D(latitude: coords[1], longitude: coords[0])
    }
    
    init(image: ImageResource, name: String, address: String, coordinate: CLLocationCoordinate2D, category: String, distance: Double? = nil) {
        self.image = image
        self.name = name
        self.address = address
        self.coordinate = coordinate
        self.category = category
        self.distance = distance
    }
}

