//
//  JSONPArsing.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/3/25.
//
import Foundation
import CoreLocation

@Observable
class JSONParsingViewModel {
    var storeData: StarbucksStoreModel?
    
    func loadStoreData(completion: @escaping (Result<StarbucksStoreModel, Error>) -> Void) {
        // JSON 파일 경로 찾기
        guard let url = Bundle.main.url(forResource: "starbucks_2025data", withExtension: "geojson") else {
            print("json 파일 없음")
            completion(.failure(NSError(domain: "파일 못찾아요!", code: 404, userInfo: nil)))
            return
        }
        
        do {
            let data = try Data(contentsOf: url) // JSON 파일에서 데이터 읽기
            // 디코딩
            let decoded = try JSONDecoder().decode(StarbucksStoreModel.self, from: data)
            self.storeData = decoded
            print("디코딩 성공")
            completion(.success(decoded))
        } catch {
            print("디코딩 실패: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }

    func resolveAddresses(for features: [StoreFeature]) async -> [StoreFeature] {
        var updatedFeatures = features
        let geocoder = CLGeocoder()

        let limitedFeatures = Array(features.prefix(10)) // 앞에서 10개만

        for (index, feature) in limitedFeatures.enumerated() {
            let location = CLLocation(latitude: feature.properties.yCoordinate, longitude: feature.properties.xCoordinate)
            do {
                let placemarks = try await geocoder.reverseGeocodeLocation(location)
                if let placemark = placemarks.first {
                    updatedFeatures[index].properties.resolvedAddress = [
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
