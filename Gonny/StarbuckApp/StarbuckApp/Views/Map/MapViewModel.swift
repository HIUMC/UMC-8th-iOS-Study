//
//  MapViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/30/25.
//
import Foundation
import Observation
import MapKit
import CoreLocation
import SwiftUI


class MapViewModel: ObservableObject {
    let locationManager: LocationManager

    init(locationManager: LocationManager = LocationManager.shared) {
        self.locationManager = locationManager
        //loadStores()
    }

    var stores: [StoreFeature] = []
    
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
        print("업데이트마커 호출됨")
        print("현재 store 개수: \(stores.count)")

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
            print("가게: \(feature.properties.storeName), 거리: \(distance)m")

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

        print("생성된 markers 개수: \(markers.count)")
        for marker in markers {
            print("마커 제목: \(marker.title), 위치: \(marker.coordinate.latitude), \(marker.coordinate.longitude)")
        }
    }


}

