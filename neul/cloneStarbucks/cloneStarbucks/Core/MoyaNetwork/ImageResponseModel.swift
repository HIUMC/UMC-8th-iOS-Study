//
//  ImageResponseModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/26/25.
//

import Foundation

struct PlaceResponseModel: Codable {
    let results: [GooglePlace]
}

struct GooglePlace: Codable {
    let photos: [GooglePhoto]?
}

struct GooglePhoto: Codable {
    let photoReference: String
    
    enum CodingKeys: String, CodingKey {
        case photoReference = "photo_reference"
    }
}
