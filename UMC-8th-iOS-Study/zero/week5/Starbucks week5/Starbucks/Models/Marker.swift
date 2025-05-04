//
//  Marker.swift
//  Starbucks
//
//  Created by 김영택 on 5/3/25.
//

import Foundation
import MapKit

struct Marker: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}
