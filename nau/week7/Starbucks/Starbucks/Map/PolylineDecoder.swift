//
//  PolylineDecoder.swift
//  Starbucks
//
//  Created by nau on 5/22/25.
//

import Foundation
import CoreLocation

class PolylineDecoder {
    static func decodePolyline(_ encoded: String) -> [CLLocationCoordinate2D] {
        var coordinates: [CLLocationCoordinate2D] = []
        var index = encoded.startIndex
        let count = encoded.count
        var lat = 0
        var lng = 0

        while index < encoded.endIndex {
            var b: Int
            var shift = 0
            var result = 0

            repeat {
                b = Int(encoded[index].asciiValue!) - 63
                result |= (b & 0x1F) << shift
                shift += 5
                index = encoded.index(after: index)
            } while b >= 0x20

            let deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1))
            lat += deltaLat

            shift = 0
            result = 0

            repeat {
                b = Int(encoded[index].asciiValue!) - 63
                result |= (b & 0x1F) << shift
                shift += 5
                index = encoded.index(after: index)
            } while b >= 0x20

            let deltaLon = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1))
            lng += deltaLon

            let latitude = Double(lat) / 1e5
            let longitude = Double(lng) / 1e5
            coordinates.append(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        }

        return coordinates
    }
}
