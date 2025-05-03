//
//  MapViewModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/1/25.
//
import Foundation
import Observation
import MapKit
import CoreLocation
import SwiftUI

@Observable
class MapViewModel {
    var stores: [StoreFeature] = []
    init() {
            loadStores()
        }

    func loadStores() {
        if let url = Bundle.main.url(forResource: "stores", withExtension: "geojson"),
           let data = try? Data(contentsOf: url),
           let decoded = try? JSONDecoder().decode(StarbucksStoreModel.self, from: data) {
            self.stores = decoded.features
        } else {
            print("❌ store.geojson 파일을 로드하거나 디코딩하는 데 실패했습니다.")
        }
    }
    var userLocation: CLLocation? {
        LocationManager.shared.currentLocation
    }

    var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780), // 초기값: 서울 중심
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    var didEnterGeofence: Bool = false
    let geofenceRadius: CLLocationDistance = 100

    var markers: [Marker] = []

    func distance(to store: StoreFeature) -> CLLocationDistance? {
        guard let userLocation else { return nil }

        let storeLocation = CLLocation(
            latitude: store.properties.yCoordinate,
            longitude: store.properties.xCoordinate
        )

        return userLocation.distance(from: storeLocation)
    }

    func sortedStoresByDistance() -> [StoreFeature] {
        stores.sorted {
            let d1 = distance(to: $0) ?? Double.greatestFiniteMagnitude
            let d2 = distance(to: $1) ?? Double.greatestFiniteMagnitude
            return d1 < d2
        }
    }
    
    func updateMarkers(around userLocation: CLLocationCoordinate2D, within radius: CLLocationDistance = 10000) {
        print("📍업데이트마커 호출됨")
        print("🔢현재 store 개수: \(stores.count)")

        markers = stores.compactMap { feature in
            let storeLocation = CLLocation(
                latitude: feature.properties.yCoordinate,
                longitude: feature.properties.xCoordinate
            )

            let userLoc = CLLocation(
                latitude: userLocation.latitude,
                longitude: userLocation.longitude
            )

            let distance = userLoc.distance(from: storeLocation)
            print("🛣️가게: \(feature.properties.storeName), 거리: \(distance)m")

            if distance <= radius {
                return Marker(
                    coordinate: CLLocationCoordinate2D(
                        latitude: feature.properties.yCoordinate,
                        longitude: feature.properties.xCoordinate
                    ),
                    title: feature.properties.storeName
                )
            } else {
                return nil
            }
        }

        print("✅생성된 markers 개수: \(markers.count)")
        for marker in markers {
            print("🗺️마커 제목: \(marker.title), 위치: \(marker.coordinate.latitude), \(marker.coordinate.longitude)")
        }
    }
    
    
}
