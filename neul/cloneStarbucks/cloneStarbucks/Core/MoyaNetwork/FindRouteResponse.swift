//
//  KeywordSearchResponse.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/20/25.
//

import Foundation
import CoreLocation

// MARK: - Search Place with Keyword
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




// MARK: - Convert Address to Coordinates

struct CoordinateResponse: Codable {
    let documents: [Coordinate]
}

struct Coordinate: Codable {
    let x: String
    let y: String
    
    var coordinate: CLLocationCoordinate2D? {
        guard let lon = Double(x), let lat = Double(y) else { return nil }
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}


// MARK: - PlaceName and Address Mapping

struct FindRouteModel {
    var placeName: String
    var address: String
}


// MARK: - Route Coordinate Response

struct RouteResponse: Decodable {
    let routes: [OSRMRoute]
}

struct OSRMRoute: Decodable {
    let geometry: RouteCoordinate
}

struct RouteCoordinate: Decodable {
    let coordinates: [CLLocationCoordinate2D]
    
    enum CodingKeys: String, CodingKey {
        case coordinates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let rawCoordinates = try container.decode([[Double]].self, forKey: .coordinates)
        coordinates = rawCoordinates.map {
            CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])
        }
    }
}
