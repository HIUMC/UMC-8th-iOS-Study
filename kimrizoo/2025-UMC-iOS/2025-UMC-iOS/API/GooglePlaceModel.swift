//
//  GooglePlaceResponse.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 5/29/25.
//

import Foundation

struct GooglePlaceResponse: Decodable {
    let results: [GooglePlaceResult]
}

struct GooglePlaceResult: Decodable {
    let name: String
    let photos: [GooglePhoto]?
}

struct GooglePhoto: Decodable {
    let photo_reference: String
}
