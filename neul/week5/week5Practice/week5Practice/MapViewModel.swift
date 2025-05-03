//
//  MapViewModel.swift
//  week5Practice
//
//  Created by tokkislove on 4/28/25.
//

import SwiftUI
import MapKit
import Observation

@Observable
final class MapViewModel {
    
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var currentMapCenter: CLLocationCoordinate2D?
    
    var searchResults: [Place] = []
        
    var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    // 마커
    var makers: [Marker] = [
        .init(coordinate: .init(latitude: 37.551343, longitude: 126.926563), title: "홍익대학교"),
        .init(coordinate: .init(latitude: 37.574236, longitude: 126.908453), title: "우리 집")
    ]
    
    let geofenceCoordinate = CLLocationCoordinate2D(latitude: 37.562046, longitude: 126.946802) // 본인의 학교 위도 / 경도로 넣어보세요
    let geofenceRadius: CLLocationDistance = 100
    let geofenceIdentifier = "이화여대"
        
    init() {
        LocationManager.shared.startMonitoringGeofence(center: geofenceCoordinate, radius: geofenceRadius, identifier: geofenceIdentifier)
    }
    
    func search(query: String, to locaation: CLLocation) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.region = .init(center: locaation.coordinate, span: .init(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let self, let mapItems = response?.mapItems else { return }
            
            DispatchQueue.main.async {
                self.searchResults = mapItems.map { Place(mapItem: $0) }
            }
        }
    }
}


