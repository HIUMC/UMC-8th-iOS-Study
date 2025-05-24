//
//  OrderSheetModel.swift
//  Starbucks
//
//  Created by 이가원 on 5/23/25.
//

import Foundation
import CoreLocation

struct OrderSheetModel: Identifiable {
    let id = UUID()

    let name: String
    let address: String
    var distance: Double?
    let isReserve: Bool
    let isDT: Bool
    let latitude: Double
    let longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    var tags: [String] {
        var result: [String] = []
        if isReserve { result.append("R") }
        if isDT { result.append("D") }
        return result
    }
}
