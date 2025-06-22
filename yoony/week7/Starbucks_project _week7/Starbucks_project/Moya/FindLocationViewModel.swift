//
//  KakaoTargetTypeViewModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/28/25.
//

import Foundation
import SwiftUI
import Moya
import CoreLocation

class FindLocationViewModel: ObservableObject {
    @Published var startplace: String = ""
    @Published var searchResults: [PlaceDocument] = []
    @Published var isSearching: Bool = false
    
    @Published var arriveplace: String = ""
    @Published var storeResults: [MapListModel] = []
    @Published var isArriveSearching: Bool = false
    
    @Published var isLoadingRoute: Bool = false
    @Published var routeCoordinates: [CLLocationCoordinate2D] = []
    
    private let provider = MoyaProvider<MapRouter>()
    
    func performSearch() {
        guard !startplace.isEmpty else { return }
        isSearching = true
        
        provider.request(.keywordSearch(query: startplace)) { [self] result in
            _Concurrency.Task {
                do {
                    let kakaoResponse = try await provider.requestAsync(.keywordSearch(query: self.startplace))
                    let data = try JSONDecoder().decode(KakaoSearchResponse.self, from: kakaoResponse.data)
                    
                    DispatchQueue.main.async {
                        self.searchResults = data.documents
                        self.isSearching = true
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
        func searchArriveStores() {
            guard !arriveplace.isEmpty else { return }
            
            let allStores: [MapListModel] = loadStores()
            
            let exactMatches = allStores.filter {
                $0.name.localizedCaseInsensitiveContains(arriveplace)
            }
            
            let addressMatches = allStores.filter {
                !$0.name.localizedCaseInsensitiveContains(arriveplace) &&
                $0.address.localizedCaseInsensitiveContains(arriveplace)
            }
            
            storeResults = exactMatches + addressMatches
            isArriveSearching = true
        }
        
        func loadStores() -> [MapListModel] {
            guard let url = Bundle.main.url(forResource: "MapData", withExtension: "geojson"),
                  let data = try? Data(contentsOf: url),
                  let collection = try? JSONDecoder().decode(FeatureCollection.self, from: data) else {
                print("❌ JSON 불러오기 실패")
                return []
            }
            return collection.features
        }
        
        @MainActor
        func findWalkingRoute(startQuery: String, endQuery: String) async {
            isLoadingRoute = true
            routeCoordinates = []
            
            do {
                let start = try await geocode(query: startQuery)
                let end = try await geocode(query: endQuery)
                
                let urlStr = "http://router.project-osrm.org/route/v1/foot/\(start.longitude),\(start.latitude);\(end.longitude),\(end.latitude)?overview=full&geometries=geojson"
                guard let url = URL(string: urlStr) else { return }
                
                let (data, _) = try await URLSession.shared.data(from: url)
                if let decoded = try? JSONDecoder().decode(OSRMResponse.self, from: data),
                   let coords = decoded.routes.first?.geometry.coordinates {
                    self.routeCoordinates = coords.map {
                        CLLocationCoordinate2D(latitude: $0[1], longitude: $0[0])
                    }
                }
            } catch {
                print("❌ 지오코딩 실패: \(error.localizedDescription)")
            }
            
            isLoadingRoute = false
        }
        
         func geocode(query: String) async throws -> CLLocationCoordinate2D {
            let geocoder = CLGeocoder()
            let placemarks = try await geocoder.geocodeAddressString(query)
            guard let location = placemarks.first?.location else {
                throw URLError(.badURL)
            }
            return location.coordinate
        }
        
        func findWalkingRouteLegacy(startQuery: String, endQuery: String) {
            print("🔁 Legacy 경로 검색 실행: \(startQuery) → \(endQuery)")
            // 실제 경로 계산 로직 (동기 또는 GCD 기반)
        }
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

