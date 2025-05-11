//
//  Place.swift
//  week5Practice
//
//  Created by tokkislove on 4/28/25.
//

import Foundation
import MapKit

struct Place: Identifiable, Hashable {
    let id = UUID()
    let mapItem: MKMapItem
}
