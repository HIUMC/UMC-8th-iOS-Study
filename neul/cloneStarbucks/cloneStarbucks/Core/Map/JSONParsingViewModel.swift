//
//  JSONParsingViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/29/25.
//

import Foundation
import CoreLocation

class JSONParsingViewModel: ObservableObject {
    @Published var storeData: StarbuckStoreModel?
    @Published var sortedData: [StoreProperty] = []
    
    @MainActor
    func loadStoreData(completion: @escaping (Result<StarbuckStoreModel, Error>) -> Void) {
        Task {
            do {
                guard let url = Bundle.main.url(forResource: "stores", withExtension: "geojson") else {
                    print("json 파일 없음")
                    completion(.failure(NSError(domain: "파일 못찾아요!", code: 404, userInfo: nil)))
                    return
                }

                let data = try Data(contentsOf: url)
                let decoded = try JSONDecoder().decode(StarbuckStoreModel.self, from: data)
                print("디코딩 성공")

                /*let resolvedFeatures = await self.resolveAddresses(for: decoded.features)
                decoded.features = resolvedFeatures*/
                self.storeData = decoded
                //print("주소 변환 성공")

                completion(.success(decoded))  // 이제 완성된 decoded를 넘긴다!

            } catch {
                print("디코딩 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    
    func sortAddress(by query: String) {
        guard let data = storeData else { return }
        sortedData = []

        let lowercasedQuery = query.lowercased()
        var seenIds = Set<String>()  // storeId 중복 방지용
        var uniqueResults: [StoreProperty] = []

        let nameFiltered = data.features
            .filter { $0.properties.storeName.lowercased().contains(lowercasedQuery) }
            .map { $0.properties }

        let addressFiltered = data.features
            .filter { $0.properties.address.lowercased().contains(lowercasedQuery) }
            .map { $0.properties }

        for store in nameFiltered + addressFiltered {
            if seenIds.insert(store.storeId).inserted {
                uniqueResults.append(store)
            }
        }

        sortedData = uniqueResults
    }
    
    func resolveAddresses(for features: [StoreFeature]) async -> [StoreFeature] {
        var updatedFeatures = features
        let geocoder = CLGeocoder()

        let limitedFeatures = Array(features.prefix(10)) // 앞에서 10개만

        for i in limitedFeatures.indices {
            let feature = limitedFeatures[i]
            let location = CLLocation(latitude: feature.properties.yCoordinate, longitude: feature.properties.xCoordinate)

            do {
                let placemarks = try await geocoder.reverseGeocodeLocation(location)
                if let placemark = placemarks.first {
                    updatedFeatures[i].properties.resolvedAddress = [
                        placemark.administrativeArea,
                        placemark.locality,
                        placemark.subLocality,
                        placemark.thoroughfare
                    ].compactMap { $0 }.joined(separator: " ")
                }
            } catch {
                print("역지오코딩 실패: \(error.localizedDescription)")
            }
        }

        return updatedFeatures
    }
}
