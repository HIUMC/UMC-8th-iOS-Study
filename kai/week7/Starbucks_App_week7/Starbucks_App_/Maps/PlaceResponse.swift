//
//  PlaceResponse.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/29/25.
//


import Foundation

struct PlaceResponse: Codable {
    let meta: Meta
    let documents: [Place]
}

struct Place: Codable, Identifiable {
    var id: String
    let place_name: String
    let distance: String?
    let place_url: String?
    let category_name: String?
    let address_name: String?
    let road_address_name: String?
    let phone: String?
    let category_group_code: String?
    let category_group_name: String?
    let x: String
    let y: String
}

struct Meta: Codable {
    let same_name: SameName
    let pageable_count: Int
    let total_count: Int
    let is_end: Bool
}

struct SameName: Codable {
    let region: [String]
    let keyword: String
    let selected_region: String
}









