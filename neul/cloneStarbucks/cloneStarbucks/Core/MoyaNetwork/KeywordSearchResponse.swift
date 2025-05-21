//
//  KeywordSearchResponse.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/20/25.
//

import Foundation

struct KeywordSearchResponse: Codable {
    let documents: [Place]
}

struct Place: Codable, Hashable {
    let placeName: String
    let addressName: String
    let roadAddressName: String
    let x: Double
    let y: Double
    
    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case x
        case y
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        placeName = try container.decode(String.self, forKey: .placeName)
        addressName = try container.decode(String.self, forKey: .addressName)
        roadAddressName = try container.decode(String.self, forKey: .roadAddressName)

        let xString = try container.decode(String.self, forKey: .x)
        let yString = try container.decode(String.self, forKey: .y)

        guard let xDouble = Double(xString),
              let yDouble = Double(yString) else {
            throw DecodingError.dataCorruptedError(forKey: .x, in: container, debugDescription: "좌표값 Double로 디코딩 중 에러")
        }

        x = xDouble
        y = yDouble
    }
    
}


