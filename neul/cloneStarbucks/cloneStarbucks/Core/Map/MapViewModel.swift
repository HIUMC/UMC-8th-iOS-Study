//
//  MapViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/29/25.
//

import SwiftUI
import MapKit
import Observation
import CoreLocation

class MapViewModel: ObservableObject {
    @Published var stores: [StoreFeature] = []
    @Published var displayedStores: [StarbucksImageModel] = []
    
    
    var userLocation: CLLocation? {
        LocationManager.shared.currentLocation
    }
    
    
    @Published var initialRegion: MKCoordinateRegion?
    @Published var markers: [Marker] = []
    
    @Published var routePoints: [CLLocationCoordinate2D] = []
    
    
    func distance(to store: StoreFeature) -> CLLocationDistance? {
        guard let userLocation else { return nil }
        
        let storeLocation = CLLocation(latitude: store.properties.yCoordinate, longitude: store.properties.xCoordinate)
        return userLocation.distance(from: storeLocation)
    }
    
    @MainActor
    func setStoresAndUpdate(_ stores: [StoreFeature]) async {
        do {
            _ = try await LocationManager.shared.waitForLocation()
            self.stores = stores
            self.displayedStores = stores
                .compactMap { store in
                    guard let distance = distance(to: store), distance <= 10000 else { return nil }
                    return StarbucksImageModel(
                        storeName: store.properties.storeName,
                        address: store.properties.address,
                        distance: distance,
                        category: store.properties.category,
                        imageData: nil
                    )
                }
                .sorted { $0.distance < $1.distance }
            print("Store 개수: \(self.stores.count)")
            print("displayed 개수: \(self.displayedStores.count)")
        } catch {
            print("⛔️ 위치 정보 기다리다 실패: \(error)")
        }
            
        
    }
    
    func makeInitialRegion(for coordinate: CLLocationCoordinate2D) {
        initialRegion = MKCoordinateRegion(
                center: coordinate,
                latitudinalMeters: 15000,
                longitudinalMeters: 15000
                )
    }
    
    @MainActor
    func updateMarkers(around userLocation: CLLocationCoordinate2D, within radius: CLLocationDistance = 10000) {
        print("업데이트마커 호출됨")
        print("현재 store 개수: \(stores.count)")
        self.markers = self.stores.compactMap { feature in
            let storeLocation = CLLocation(latitude: feature.properties.yCoordinate,
                                            longitude: feature.properties.xCoordinate)
            let userLoc = CLLocation(latitude: userLocation.latitude,
                                        longitude: userLocation.longitude)
                
            let distance = userLoc.distance(from: storeLocation)
                
            if distance <= radius {
                return Marker(
                    coordinate: CLLocationCoordinate2D(latitude: feature.properties.yCoordinate,
                                                        longitude: feature.properties.xCoordinate),
                    title: feature.properties.storeName
                    )
            } else {
                return nil
            }
        }
    }
    

}




