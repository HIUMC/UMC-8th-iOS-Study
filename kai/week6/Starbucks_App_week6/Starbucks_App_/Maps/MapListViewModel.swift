//
//  MapListViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/4/25.
//


import Foundation
import CoreLocation
import MapKit

@Observable
final class MapListViewModel {
    var stores: [MapListModel] = []
    var filteredStores: [MapListModel] = []

    var userLocation: CLLocation?

    func loadGeoJSON(completion: @escaping (Result<[MapListModel], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "MapData", withExtension: "geojson"),
              let data = try? Data(contentsOf: url) else { return }

        do {
            let decoder = JSONDecoder()
            let geoJSON = try decoder.decode(GeoJSON.self, from: data)
            self.stores = geoJSON.features.map {
                let store = $0.toStore()
                return store
            }

            if userLocation != nil {
                filterStoresWithin10km()
            }
            
            completion(.success(filteredStores))
            print("\(String(describing: filteredStores))")
            
        } catch {
            print("GeoJSON 파싱 오류:", error)
            completion(.failure(error))
        }
    }

    func setUserLocation(_ location: CLLocation) {
        self.userLocation = location
        filterStoresWithin10km()
    }

    private func filterStoresWithin10km() {
        guard let userLocation else { return }
        
        print("필터링 시작: \(userLocation)")

        self.filteredStores = stores.compactMap { store in
            let storeLocation = CLLocation(latitude: store.coordinate.latitude, longitude: store.coordinate.longitude)
            let distance = userLocation.distance(from: storeLocation)
            guard distance <= 10000 else { return nil }
            
            return MapListModel(
                image: store.image,
                name: store.name,
                address: store.address,
                coordinate: store.coordinate,
                category: store.category,
                distance: distance
            )
        }
        .sorted {
            let loc1 = CLLocation(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            let loc2 = CLLocation(latitude: $1.coordinate.latitude, longitude: $1.coordinate.longitude)
            return userLocation.distance(from: loc1) < userLocation.distance(from: loc2)
        }
    }
}

enum StoreCategory: String {
    case none
    case reserve
    case drive
    case both
    
    init(from category: String) {
        if category.contains("리저브") {
            self = .reserve
        } else if category.contains("DTR") {
            self = .both
        } else if category.contains("DT") {
            self = .drive
        } else {
            self = .none
        }
    }
    
    /*var icons: [ImageResource] {
        switch self {
        case .reserve:
            return [.reserve]
        case .none:
            return []
        case .drive:
            return [.drive]
        case .both:
            return [.reserve, .drive]
        }
     }*/
}
