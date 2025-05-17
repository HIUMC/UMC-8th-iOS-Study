//
//  Marker.swift
//  UMC-iOS-WorkBook-5
//
//  Created by 곽은채 on 4/28/25.
//

import Foundation
import MapKit

struct Marker: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}
