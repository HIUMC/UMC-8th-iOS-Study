//
//  JSONParsingViewModel.swift
//  Starbucks
//
//  Created by 박정환 on 5/2/25.
//

import Foundation
import CoreLocation

@Observable
class JSONParsingViewModel {
    var stores: [StoreModel] = []
    
    var userLocation: CLLocation? {
        didSet {
            updateDistances()
        }
    }
    
    var distances: [UUID: CLLocationDistance] = [:]
    
    var sortedStores: [StoreModel] {
        guard userLocation != nil, !stores.isEmpty else {
            return []
        }
        
        let radius: CLLocationDistance = 10000 // 10km
        
        let filteredStores = stores.filter { store in
            let distance = distances[store.id] ?? Double.greatestFiniteMagnitude
            return distance <= radius
        }
        
        let sortedStores = filteredStores.sorted { (store1, store2) in
            let distance1 = distances[store1.id] ?? Double.greatestFiniteMagnitude
            let distance2 = distances[store2.id] ?? Double.greatestFiniteMagnitude
            return distance1 < distance2
        }
        
        return Array(sortedStores.prefix(10))
    }
    
    // 모든 매장까지의 거리를 계산
    private func updateDistances() {
        guard let userLoc = userLocation, !stores.isEmpty else {
            distances = [:]
            return
        }
        
        var calculated = [UUID: CLLocationDistance]()
        for store in stores { // StoreModel의 xCoordinate와 yCoordinate를 사용하여 CLLocation 생성
            let storeLocation = CLLocation(latitude: store.yCoordinate, longitude: store.xCoordinate)
            let distanceInMeters = userLoc.distance(from: storeLocation)
            calculated[store.id] = distanceInMeters
        }
        self.distances = calculated
    }
    
    func loadStoreList(completion: @escaping (Result<[StoreModel], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "Starbucks", withExtension: "geojson") else {
            print("json 파일 없음")
            completion(.failure(NSError(domain: "파일 못 찾아요!", code: 404, userInfo: nil)))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let geoJson = try JSONDecoder().decode(GeoJSON.self, from: data)
            let storeList = geoJson.features.map { $0.properties }
            self.stores = storeList
            print("디코딩 성공")
            if userLocation != nil {
                updateDistances()
            }
            completion(.success(storeList))
        } catch {
            print("디코딩 실패: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
}
