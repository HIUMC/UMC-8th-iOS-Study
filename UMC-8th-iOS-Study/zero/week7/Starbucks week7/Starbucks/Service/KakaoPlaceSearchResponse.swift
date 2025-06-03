//
//  KakaoPlaceSearchResponse.swift
//  Starbucks
//
//  Created by 김영택 on 5/29/25.
//

import Foundation

// 전체 응답 구조
struct KakaoPlaceSearchResponse: Codable {
    let meta: Meta
    let documents: [Place]
}

// 메타 정보
struct Meta: Codable {
    let total_count: Int           // 전체 검색 결과 수
    let pageable_count: Int        // 노출 가능한 결과 수
    let is_end: Bool               // 마지막 페이지 여부
}

// 장소 정보
struct Place: Codable, Identifiable {
    let id: String                 // 장소 ID
    let place_name: String         // 장소 이름
    let road_address_name: String? // 도로명 주소
    let address_name: String?      // 지번 주소
    let phone: String?             // 전화번호
    let x: String                  // 경도
    let y: String                  // 위도
    let place_url: String          // 장소 상세 URL
    let category_name: String?     // 카테고리
    let distance: String?          // 거리 (선택사항)
}

