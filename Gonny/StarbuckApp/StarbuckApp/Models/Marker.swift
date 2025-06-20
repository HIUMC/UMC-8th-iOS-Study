//
//  Marker.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/30/25.
//
import Foundation
import MapKit

struct Marker: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let title: String
}
