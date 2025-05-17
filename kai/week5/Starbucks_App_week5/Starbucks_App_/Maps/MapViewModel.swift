//
//  MapViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/3/25.
//

import SwiftUI
import MapKit
import Observation

@Observable
/*final class MapViewModel {
    
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
}*/

final class MapViewModel {
    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var makers: [Marker] = []

    let geofenceCoordinate = CLLocationCoordinate2D(latitude: 36.013024, longitude: 129.326010)
    let geofenceRadius: CLLocationDistance = 200
    let geofenceIdentifier = "포항공대"

    init() {
        LocationManager.shared.startMonitoringGeofence(center: geofenceCoordinate, radius: geofenceRadius, identifier: geofenceIdentifier)
        let current = LocationManager.shared.currentLocation
        loadMarkersFromGeoJSON(userLocation: current)
    }

    func loadMarkersFromGeoJSON(userLocation: CLLocation?) {
        guard let url = Bundle.main.url(forResource: "MapData", withExtension: "geojson"),
              let data = try? Data(contentsOf: url) else {
            print("GeoJSON 파일을 찾을 수 없습니다.")
            return
        }

        do {
            let decoder = JSONDecoder()
            let geoJSON = try decoder.decode(GeoJSON.self, from: data)

            let features = geoJSON.features

            // 현재 위치가 없는 경우 전체 표시
            guard let userLocation else {
                self.makers = features.map { feature in
                    let name = feature.properties.storeName
                    let coordinate = CLLocationCoordinate2D(latitude: feature.properties.latitude,
                                                            longitude: feature.properties.longitude)
                    return Marker(coordinate: coordinate, title: name)
                }
                return
            }

            // 위치 기준 10km 필터링
            self.makers = features.compactMap { feature in
                let coordinate = CLLocationCoordinate2D(latitude: feature.properties.latitude,
                                                        longitude: feature.properties.longitude)
                let storeLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                let distance = userLocation.distance(from: storeLocation)
                guard distance <= 10_000 else { return nil }

                return Marker(coordinate: coordinate, title: feature.properties.storeName)
            }

        } catch {
            print("GeoJSON 파싱 오류: \(error)")
        }
    }
}
