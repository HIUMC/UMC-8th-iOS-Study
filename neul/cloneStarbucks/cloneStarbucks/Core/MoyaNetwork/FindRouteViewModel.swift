//
//  FindRouteViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/20/25.
//

import SwiftUI
import Observation
import CoreLocation
import Moya

class FindRouteViewModel: ObservableObject {
    let provider: MoyaProvider<FindRoute>
    
    init(provider: MoyaProvider<FindRoute> = APIManager.shared.createProvider(for: FindRoute.self)) {
        self.provider = provider
    }
    
    @Published var searchResults: [Place] = []
    
    func searchWithKeyword(query: String) {
        provider.request(.keywordSearch(query: query)) { result in
            switch result {
            case .success(let response):
                do {
                    let placeResponse = try JSONDecoder().decode(KeywordSearchResponse.self, from: response.data)
                    self.searchResults = placeResponse.documents
                    print("장소 검색 API 받아오기 성공!")
                } catch {
                    print("장소 검색 API 디코딩 실패:", error)
                }
            case .failure(let error):
                print("장소 검색 API 실패:", error)
            }
        }
    }

}


extension FindRouteViewModel {
    var userLocation: CLLocation? {
        LocationManager.shared.currentLocation
    }
    
    // 역지오코딩 함수
    func resolveAddress(for location: CLLocation) async -> String {
        let geocoder = CLGeocoder()
        var locationString = ""

        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let administrativeArea = placemark.administrativeArea
                let locality = (placemark.locality == administrativeArea) ? nil : placemark.locality
                let subLocality = placemark.subLocality
                let thoroughfare = (placemark.thoroughfare == subLocality) ? nil: placemark.thoroughfare

                locationString = [
                    administrativeArea,
                    locality,
                    subLocality,
                    thoroughfare
                ].compactMap { $0 }.joined(separator: " ")
            }
        } catch {
            print("역지오코딩 실패: \(error.localizedDescription)")
        }
        print("decoded location: \(locationString)")
        return locationString
    }
}
