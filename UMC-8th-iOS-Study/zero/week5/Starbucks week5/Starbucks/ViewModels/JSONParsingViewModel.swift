//
//  JSONParsingViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 5/3/25.
//

import Foundation
import CoreLocation

class JSONParsingViewModel: ObservableObject {
    @Published var stores: [MyModel] = []
    
    func loadStores() {
        guard let url = Bundle.main.url(forResource: "Starbucks", withExtension: "geojson") else {
            print("JSON 파일을 찾을 수 없습니다.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([String: [MyModel]].self, from: data)
            self.stores = decoded["features"] ?? []
        } catch {
            print("디코딩 실패: \(error.localizedDescription)")
        }
    }
    
    func sortedByDistance(from userLocation: CLLocation) -> [MyModel] {
        return stores
            .filter {
                let loc = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
                return loc.distance(from: userLocation) <= 10_000 // 10km 이내
            }
            .sorted {
                let loc1 = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
                let loc2 = CLLocation(latitude: $1.latitude, longitude: $1.longitude)
                return loc1.distance(from: userLocation) < loc2.distance(from: userLocation)
            }
    }
}

