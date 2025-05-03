//
//  MapViewModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/3/25.
//
/*
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
        .init(coordinate: .init(latitude: 37.529598, longitude: 126.963946), title: "용산 CGV")
    ]

    let geofenceCoordinate = CLLocationCoordinate2D(latitude: 36.013024, longitude: 129.326010) // 본인의 학교 위도 / 경도로 넣어보세요
    let geofenceRadius: CLLocationDistance = 100
    let geofenceIdentifier = "포항공대"
    
    init() {
        LocationManager.shared.startMonitoringGeofence(center: geofenceCoordinate, radius: geofenceRadius, identifier: geofenceIdentifier)
    }
}
*/
