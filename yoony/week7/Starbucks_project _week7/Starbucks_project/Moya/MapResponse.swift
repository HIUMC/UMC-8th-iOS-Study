//
//  MapResponse.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/29/25.
//

import Foundation

// 전체 응답 구조
struct KakaoSearchResponse: Codable {
    let meta: Meta
    let documents: [PlaceDocument]
}

// META (페이징 등 정보)
struct Meta: Codable {
    let total_count: Int
    let pageable_count: Int
    let is_end: Bool
    let same_name: SameName
}

// META - same_name 필드
struct SameName: Codable {
    let region: [String]
    let keyword: String
    let selected_region: String
}

// 장소 정보
struct PlaceDocument: Codable, Identifiable {
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
    let x: String  // 경도
    let y: String  // 위도
}
