//
//  jsonParsingViewModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/1/25.
// 디코딩해서 가져와 ~~~~
import Foundation
import CoreLocation

@Observable
class JSONParsingViewModel {
    var storeData: StarbucksStoreModel?
    
    func loadStoreData(completion: @escaping (Result<StarbucksStoreModel, Error>) -> Void) {
        Task {
            do {
                // JSON 파일 경로 찾기
                guard let url = Bundle.main.url(forResource: "stores", withExtension: "geojson") else {
                    print("json 파일 없음")
                    completion(.failure(NSError(domain: "파일 못찾았어요!", code: 404, userInfo: nil)))
                    return
                }
                
                // JSON 파일에서 데이터 읽기
                let data = try Data(contentsOf: url)
                
                // 디코딩
                var decoded = try JSONDecoder().decode(StarbucksStoreModel.self, from: data)
                print("디코딩 성공")
                
                /// 주소 해석
                 var resolvedFeatures = await self.resolveAddresses(for: decoded.features)
                 decoded.features = resolvedFeatures
                
                // 상태에 저장
                self.storeData = decoded
                // print("주소 반영 성공")
                
                completion(.success(decoded)) // 완성된 decoded를 보내요
            } catch {
                print("디코딩 실패: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
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
