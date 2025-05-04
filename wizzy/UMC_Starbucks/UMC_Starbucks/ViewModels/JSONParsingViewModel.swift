//
//  JSONParsingViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/3/25.
//

import Foundation
import CoreLocation

//@Observable
class JSONParsingViewModel: ObservableObject {
    @Published var myProfile: MyModel?
    @Published var allStores: [Feature] = []
    @Published var sortedStores: [Feature] = []
    private var currentLocation: CLLocation? {
        return LocationManager.shared.currentLocation
    }
    
    func loadMyProfile(completion: @escaping (Result<MyModel, Error>) -> Void) {
        print("🟡 loadMyProfile() 함수 진입")
        
        guard let url = Bundle.main.url(forResource: "starbucks2025", withExtension: "geojson") else {
            print("❌ JSON 파일을 찾을 수 없음")
            completion(.failure(NSError(domain: "파일 못찾아요!", code: 404, userInfo: nil)))
            return
        }

        do {
            print("📦 JSON 파일 로딩 시도")
            let data = try Data(contentsOf: url)
            print("📄 JSON 데이터 크기: \(data.count) bytes")
            
            let decoded = try JSONDecoder().decode(GeoJSONFile.self, from: data)
            self.allStores = decoded.features
            self.sortStoresByDistance()
            print("✅ features 개수: \(decoded.features.count)")
            if let firstFeature = decoded.features.first {
                self.myProfile = firstFeature.properties
                print("✅ 첫 번째 매장 이름: \(firstFeature.properties.storeName ?? "없음")")
                completion(.success(firstFeature.properties))
            } else {
                print("❌ features 배열이 비어 있습니다")
                completion(.failure(NSError(domain: "features 없음", code: 204, userInfo: nil)))
            }
        } catch {
            print("❌ 디코딩 실패: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    func sortStoresByDistance() {
        guard let current = currentLocation else {
            print("❌ 현재 위치를 가져올 수 없습니다")
            return
        }

        self.sortedStores = allStores.sorted {
            let loc1 = CLLocation(latitude: $0.properties.ycoordinate, longitude: $0.properties.xcoordinate)
            let loc2 = CLLocation(latitude: $1.properties.ycoordinate, longitude: $1.properties.xcoordinate)
            return loc1.distance(from: current) < loc2.distance(from: current)
        }
    }
}

// Extension to calculate distance from user for any Feature << GPT
extension Feature {
    /// Returns the distance from the user's current location in kilometers, or nil if user location is unavailable.
    var distanceFromUser: Double? {
        guard let userLocation = LocationManager.shared.currentLocation else { return nil }
        let storeLocation = CLLocation(latitude: self.properties.ycoordinate, longitude: self.properties.xcoordinate)
        let distanceInMeters = storeLocation.distance(from: userLocation)
        return distanceInMeters / 1000.0
    }
}
