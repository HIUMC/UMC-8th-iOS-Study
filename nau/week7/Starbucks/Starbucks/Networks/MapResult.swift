//
//  MapResult.swift
//  Starbucks
//
//  Created by nau on 5/21/25.
//

import Foundation

struct SearchAddress: Codable {
    let meta: Meta
    let documents: [Place]
}

struct Meta: Codable {
    let total_count: Int
    let pageable_count: Int
    let is_end: Bool
    let same_name: SameName
}

struct SameName: Codable {
    let region: [String]
    let keyword: String
    let selected_region: String
}

struct Place: Codable, Identifiable {
    let id: String
    let place_name: String
    let category_name: String
    let category_group_code: String
    let category_group_name: String
    let phone: String
    let address_name: String
    let road_address_name: String
    let x: String
    let y: String
    let place_url: String
    let distance: String
}

struct RouteResponse: Decodable {
    let code: String
    let routes: [Route]

    struct Route: Decodable {
        let geometry: String
        let legs: [Leg]
        let weight_name: String
        let weight: Double
        let duration: Double
        let distance: Double
    }

    struct Leg: Decodable {
        let steps: [Step]
        let summary: String
        let weight: Double
        let duration: Double
        let distance: Double
    }

    struct Step: Decodable {
        // 비워두거나 실제 step 구조 맞춰서 작성
    }
}

struct PlaceSearchResponse: Codable {
    let candidates: [Candidate]
    struct Candidate: Codable {
        let place_id: String
    }
}

struct PlaceDetailsResponse: Codable {
    let result: PlaceResult
}

struct PlaceResult: Codable {
    let photos: [PlacePhoto]?
}

struct PlacePhoto: Codable {
    let photo_reference: String
}
