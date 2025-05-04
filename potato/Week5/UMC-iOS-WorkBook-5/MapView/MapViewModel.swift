//
//  MapViewModel.swift
//  UMC-iOS-WorkBook-5
//
//  Created by 곽은채 on 4/28/25.
//

import SwiftUI
import MapKit
import Observation

@Observable
final class MapViewModel {
    
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var didEnterGeofence: Bool = false
    
    // 마커
    var makers: [Marker] = [
        .init(coordinate: .init(latitude: 37.504675, longitude: 126.957034), title: "중앙대학교"),
        .init(coordinate: .init(latitude: 37.550901, longitude: 126.926123), title: "홍익대학교")
    ]

    let geofenceCoordinate = CLLocationCoordinate2D(latitude: 37.550901, longitude: 126.926123)
    let geofenceRadius: CLLocationDistance = 100
    let geofenceIdentifier = "홍익대"
    
    init() {
        LocationManager.shared.startMonitoringGeofence(center: geofenceCoordinate, radius: geofenceRadius, identifier: geofenceIdentifier)
    }
}
