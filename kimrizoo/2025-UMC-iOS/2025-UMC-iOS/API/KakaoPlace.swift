//
//  KakaoPlace.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 5/29/25.
//

import Foundation

struct KakaoPlace: Decodable, Identifiable {
    let id = UUID()
    let placeName: String
    let addressName: String
    
    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case addressName = "address_name"
    }
}

struct KakaoPlaceResponse: Decodable {
    let documents: [KakaoPlace]
}
