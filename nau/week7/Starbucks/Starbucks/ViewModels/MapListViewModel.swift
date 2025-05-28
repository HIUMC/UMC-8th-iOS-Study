//
//  MapListViewModel.swift
//  Starbucks
//
//  Created by nau on 5/2/25.
//

import Foundation
import CoreLocation
import MapKit
import Moya
import Kingfisher

@Observable
final class MapListViewModel {
    var stores: [MapListModel] = []
    var filteredStores: [MapListModel] = []

    var userLocation: CLLocation?
    
    let provider: MoyaProvider<MapRouter> = .init()
    
    var imageURL: [UUID: URL] = [:]

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
    
    func getPhotoURL(for store: MapListModel) { // 사진 url 불러오기
        _Concurrency.Task {
            do {
                let response1 = try await provider.requestAsync(.getPlaceId(query: "스타벅스 \(store.name)점"))
                let searchData = try JSONDecoder().decode(PlaceSearchResponse.self, from: response1.data)
                guard let placeID = searchData.candidates.first?.place_id else { return }
                
                let response2 = try await provider.requestAsync(.getPhotoURL(query: placeID))
             
                let data = try JSONDecoder().decode(PlaceDetailsResponse.self, from: response2.data)
                print(data)
                if let imageURL = data.result.photos?.first?.photo_reference {
                    let fullURL = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(imageURL)&key=\(BuildSetting.googleApiKey)"
                    self.imageURL[store.id] = URL(string: fullURL)
                }
            } catch {
                print(error.localizedDescription)
            }
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
    
    var icons: [Image] {
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
    }
}
