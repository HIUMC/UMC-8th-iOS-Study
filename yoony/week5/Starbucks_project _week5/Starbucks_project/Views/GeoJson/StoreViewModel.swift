//
//  GeoJsonViewModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/3/25.
//

import Foundation
import CoreLocation

// StoreFeature를 매장 데이터 모델로 사용
class StoreViewModel: ObservableObject {
    @Published var stores: [StoreFeature] = []  // 매장 목록
    @Published var currentLocation: CLLocation?  // 현재 위치를 저장할 변수

    private var locationManager = CLLocationManager()

    // 매장 데이터 로드 함수
    func loadStores() {
        // 예시로 GeoJSON 파일을 로드하는 로직입니다.
        guard let loadedStores = loadStoreData(from: "storeData") else { return }
        self.stores = loadedStores
        
        // 현재 위치를 설정하고 거리를 계산할 수도 있습니다.
        updateCurrentLocation()
    }
    
    // 현재 위치 업데이트 (예시로 가상의 위치 설정)
    func updateCurrentLocation() {
        // 실제 앱에서는 CoreLocation을 사용해 현재 위치를 가져와야 합니다.
        // 예시로 고정된 위치 사용
        self.currentLocation = CLLocation(latitude: 37.484768, longitude: 126.930467)
    }
    
    // 매장과 현재 위치 간 거리 계산 (km 단위)
    func distanceFromCurrentLocation(store: StoreFeature) -> Double {
        guard let currentLocation = self.currentLocation else { return 0.0 }
        
        let storeLocation = CLLocation(latitude: store.geometry.coordinates[1], longitude: store.geometry.coordinates[0])
        let distance = currentLocation.distance(from: storeLocation) / 1000  // 거리(Km)로 변환
        return distance
    }
    
    // GeoJSON 파일 로드 함수 (매장 데이터를 파싱)
    func loadStoreData(from fileName: String) -> [StoreFeature]? {
        // 파일 경로 설정
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("파일을 찾을 수 없습니다.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let storeData = try decoder.decode(StoreData.self, from: data)
            return storeData.features  // 매장 목록 반환
        } catch {
            print("데이터 파싱 오류: \(error)")
            return nil
        }
    }
    func filterStores(around center: CLLocationCoordinate2D) {
        let centerLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        stores = stores.filter {
            let storeLocation = CLLocation(latitude: $0.geometry.coordinates[1], longitude: $0.geometry.coordinates[0])
            return storeLocation.distance(from: centerLocation) <= 10000
        }
    }

}
