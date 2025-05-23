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
    
    
    
    func addressToCoordinate(address: String) async throws -> (Double, Double)? {
        do {
            let response = try await provider.requestAsync(.addressToCoordinate(add: address))
            let coordResponse = try JSONDecoder().decode(CoordinateResponse.self, from: response.data)
            guard let coord = coordResponse.documents.first?.coordinate else {
                print("좌표 변환 실패")
                return nil
            }
            return (coord.longitude, coord.latitude)
        } catch {
            print("좌표 변환 API 디코딩 실패:", error)
            throw error
        }
    }
    
    
    func requestOsrmRoute(source: (Double, Double), dest: (Double, Double)) async throws -> [CLLocationCoordinate2D] {
        do {
            let response = try await provider.requestAsync(.osrmRoute(source: source, dest: dest))
            let routeResponse = try JSONDecoder().decode(RouteResponse.self, from: response.data)
            print("osrm route API 받아오기 성공!")
            return routeResponse.routes[0].geometry.coordinates
        } catch {
            print("osrm route API 실패:", error)
            return []
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
