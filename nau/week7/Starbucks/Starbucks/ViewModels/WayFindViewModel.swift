//
//  WayFindViewModel.swift
//  Starbucks
//
//  Created by nau on 5/20/25.
//
import CoreLocation
import SwiftUI
import Moya
import Foundation

@Observable
class WayFindViewModel {
    var provider: MoyaProvider<MapRouter>
    
    init(provider: MoyaProvider<MapRouter> = APIManager.shared.createProvider(for: MapRouter.self)) {
        self.provider = provider
    }

    var keywordResults: [Place] = []
    var stores: [MapListModel] = []
    var filteredStores: [MapListModel] = []
    
    var locationManager: LocationManager = .shared
    
    let geocoder = CLGeocoder()
    var address = ""

    var routeCoordinates: [CLLocationCoordinate2D] = []
    
    func startlocation() {
        locationManager.startUpdatingLocation()
        _Concurrency.Task {
            await reverseGeocoding()
        }
    }
    
    func reverseGeocoding() async {
        guard let location = locationManager.currentLocation else {
            locationManager.stopUpdatingLocation()
            print("현재 위치 정보가 없습니다.")
            return
        }
        
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let address = [
                    placemark.administrativeArea, // 시/도: 서울 특별시
                    placemark.locality, // 시/구 : 마포구
                    placemark.subLocality, // 동 : 망원동
                    placemark.name, // 전체 이름 : 망원동 382-33
                ].compactMap { $0 }
                    .removingDuplicates() // 중복 제거
                    .joined(separator: " ")
                
                self.address = address
                print("주소: \(address)")
            }
        } catch {
            print("역지오코딩 에러: \(error.localizedDescription)")
        }
    }
    
    func searchAddress(keyword: String) {
        _Concurrency.Task {
            do {
                let response = try await provider.requestAsync(.getSearchAddress(query: keyword))
                let data = try JSONDecoder().decode(SearchAddress.self, from: response.data)
                
                DispatchQueue.main.async {
                    self.keywordResults = data.documents
                }
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
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

            completion(.success(filteredStores))
            print("\(String(describing: filteredStores))")
            
        } catch {
            print("GeoJSON 파싱 오류:", error)
            completion(.failure(error))
        }
    }
    
    func searchAddressEnd(keyword: String) {
        self.filteredStores = stores.filter { store in
            store.name.contains(keyword) || store.address.contains(keyword)
        }
    }
    
    func getRoute(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) async throws -> RouteResponse.Route {
        let start = String(format: "%.6f,%.6f", start.longitude, start.latitude)
        let end = String(format: "%.6f,%.6f", end.longitude, end.latitude)

        print("➡️ 요청 경로: \(start);\(end)")

        let response = try await provider.requestAsync(.getOrsmRoute(start: start, end: end))
        print("✅ 응답 코드: \(response.statusCode)")

        do {
            let data = try JSONDecoder().decode(RouteResponse.self, from: response.data)
            guard let route = data.routes.first else {
                throw NSError(domain: "NoRouteFound", code: -1)
            }
            
            // 경로 좌표 디코딩
            self.routeCoordinates = PolylineDecoder.decodePolyline(route.geometry)
            return route
        } catch {
            throw error
        }
    }
}

// 중복 제거
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var seen: Set<Element> = []
        return filter { seen.insert($0).inserted }
    }
}

extension MoyaProvider {
    func requestAsync(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
