//
//  MapResult.swift
//  Starbucks
//
//  Created by nau on 5/21/25.
//

import Foundation

struct SearchAddress: Codable {
    let document: [Place]
}

struct Place: Codable, Identifiable {
    var id: String {
        place_name + address_name
    }
    let place_name : String
    let address_name : String
    let road_address_name : String?
}
