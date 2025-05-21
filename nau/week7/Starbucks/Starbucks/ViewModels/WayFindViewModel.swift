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
    let provider: MoyaProvider<MapRouter>
    
    init(provider: MoyaProvider<MapRouter> = APIManager.shared.createProvider(for: MapRouter.self)) {
        self.provider = provider
        
        locationManager.startUpdatingLocation()
        Task {
            await reverseGeocoding()
        }
    }
    
    var keywordResults: [Place] = []
    
    var locationManager: LocationManager = .shared
    
    let geocoder = CLGeocoder()
    var address = ""

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
    
    func searchAddress(keyword: String) async {
        do {
            let response = try await provider.requestAsync(.getSearchAddress(query: keyword))
            let data = try JSONDecoder().decode(SearchAddress.self, from: response.data)
            print("\(data)")
        }
        catch {
            print(error.localizedDescription)
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
