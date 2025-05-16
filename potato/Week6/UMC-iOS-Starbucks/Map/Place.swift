//
//  Place.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 5/1/25.
//

import Foundation
import MapKit

struct Place: Identifiable, Hashable {
    let id = UUID()
    let mapItem: MKMapItem
}
