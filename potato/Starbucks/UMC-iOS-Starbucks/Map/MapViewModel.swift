//
//  SearchViewModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 5/1/25.
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
    
    var distances: [UUID: CLLocationDistance] = [:] // 각 매장까지의 거리 정보를 저장 (매장 ID: 거리)
    
    var stores: [StoreModel] = []
    
    var makers: [Marker] = [] // 마커
    
    // 사용자 현재 위치
    var userLocation: CLLocation? {
        didSet { // 사용자 위치가 변경될 때마다 모든 매장까지의 거리 정보를 업데이트합니다.
            updateDistances()
            if let userLoc = userLocation {
                cameraPosition = .userLocation(fallback: .automatic)
            }
        }
    }
    
    var allNearbyStores: [StoreModel] { // 10km 이내 모든 매장 데이터 (StoreModel 형태)
        guard !stores.isEmpty else {
            return []
        }
        let radius: CLLocationDistance = 10000 // 10km
        return stores.filter { store in
            let distance = distances[store.id] ?? Double.greatestFiniteMagnitude
            return distance <= radius
        }
    }
    
    // 지도에 표시할 마커 목록: allNearbyStores를 Marker 형태로 변환
    var nearbyMarkers: [Marker] {
         // allNearbyStores 배열을 순회하며 Marker 객체 생성
        let markers = allNearbyStores.map { store in
            let coordinate = CLLocationCoordinate2D(latitude: store.yCoordinate, longitude: store.xCoordinate)
            let title = store.storeName
            return Marker(coordinate: coordinate, title: title)
        }
        return markers
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
    
    // JSON 파일을 읽어와 데이터를 로드하는 함수
    func loadStoresFromJson(filename: String = "Starbucks.geojson") {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("Error: \(filename) 파일을 찾을 수 없습니다.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let geoJson = try JSONDecoder().decode(GeoJSON.self, from: data)
            let storeList = geoJson.features.map { $0.properties }
            self.stores = storeList
            print("디코딩 성공: stores 배열에 총 \(self.stores.count) 개의 매장 데이터 할당 완료.")
        } catch {
            print("디코딩 실패: \(error.localizedDescription)")
        }
    }
    
    // LocationManager로부터 위치 업데이트를 받을 때 호출
    func updateFromLocation(_ location: CLLocation?) {
        // 사용자 위치로 지도 중심 이동 등 로직 (기존 코드)
        guard let currentLocation = location else { return }
        let userCoordinate = currentLocation.coordinate
        let region = MKCoordinateRegion(center: userCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.cameraPosition = .region(region)
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
