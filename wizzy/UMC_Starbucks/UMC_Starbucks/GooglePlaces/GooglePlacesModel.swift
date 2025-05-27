//
//  GooglePlacesModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/23/25.
//

import Foundation

struct GooglePlacesResponse: Codable {
    let results: [GooglePlaceResult]
}

struct GooglePlaceResult: Codable {
    let photos: [GooglePlacePhoto]?
}

struct GooglePlacePhoto: Codable {
    let photoReference: String

    enum CodingKeys: String, CodingKey {
        case photoReference = "photo_reference"
    }
}
