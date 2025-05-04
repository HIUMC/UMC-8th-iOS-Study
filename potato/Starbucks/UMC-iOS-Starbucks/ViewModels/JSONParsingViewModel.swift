//
//  JSONParsingViewModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 5/1/25.
//

import Foundation
import CoreLocation

@Observable
class JSONParsingViewModel {
    var stores: [StoreModel] = []
    
    // 사용자 현재 위치
    var userLocation: CLLocation? {
        didSet {
            // 사용자 위치가 변경될 때마다 모든 매장까지의 거리 정보를 업데이트합니다.
            updateDistances()
        }
    }
    
    // 각 매장까지의 거리 정보를 저장 (매장 ID: 거리)
    var distances: [UUID: CLLocationDistance] = [:]
    
    // 거리 기준으로 정렬된 매장 목록
    var sortedStores: [StoreModel] {
        // 사용자 위치가 없거나 매장 데이터가 없으면 빈 목록 반환
        guard userLocation != nil, !stores.isEmpty else {
            return []
        }
        
        let radius: CLLocationDistance = 10000 // 10km
        
        // 10km 반경 내 매장만 필터링
        let filteredStores = stores.filter { store in
            let distance = distances[store.id] ?? Double.greatestFiniteMagnitude // 거리가 없으면 무한대 값으로 처리
            return distance <= radius
        }
        
        // 필터링된 매장 목록을 거리 기준으로 정렬
        let sortedStores = filteredStores.sorted { (store1, store2) in
            let distance1 = distances[store1.id] ?? Double.greatestFiniteMagnitude
            let distance2 = distances[store2.id] ?? Double.greatestFiniteMagnitude
            return distance1 < distance2
        }
        
        return Array(sortedStores.prefix(10))
    }
    
    // 모든 매장까지의 거리를 계산
    private func updateDistances() {
        guard let userLoc = userLocation, !stores.isEmpty else { // 사용자 위치가 없거나 매장 목록이 비어있으면 거리 계산 및 정렬 수행 안 함
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
