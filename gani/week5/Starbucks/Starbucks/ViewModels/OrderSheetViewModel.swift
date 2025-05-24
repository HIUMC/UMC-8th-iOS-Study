//
//  OrderSheetViewModel.swift
//  Starbucks
//
//  Created by 이가원 on 5/23/25.
//
import Foundation
import MapKit
import CoreLocation

class OrderSheetViewModel: ObservableObject {
    @Published var stores: [OrderSheetModel] = []

    func loadGeoJson(completion: @escaping (Result<[OrderSheetModel], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "starbucksdata", withExtension: "geojson") else {
            print("GeoJSON 파일을 찾을 수 없습니다.")
            completion(.failure(NSError(domain: "GeoJSONNotFound", code: 404)))
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let features = try MKGeoJSONDecoder().decode(data)
                .compactMap { $0 as? MKGeoJSONFeature }

            var results: [OrderSheetModel] = []

            for feature in features {
                guard
                    let propertiesData = feature.properties,
                    let props = try JSONSerialization.jsonObject(with: propertiesData) as? [String: Any],
                    let name = props["Sotre_nm"] as? String,
                    let address = props["Address"] as? String,
                    let category = props["Category"] as? String,
                    let lat = props["Ycoordinate"] as? Double,
                    let lon = props["Xcoordinate"] as? Double
                else {
                    continue
                }

                let store = OrderSheetModel(
                    name: name,
                    address: address,
                    distance: nil,
                    isReserve: category.contains("리저브"),
                    isDT: category.contains("DT"),
                    latitude: lat,
                    longitude: lon
                )

                results.append(store)
            }

            self.stores = results
            print("파싱 성공")
            completion(.success(results))

        } catch {
            print("파싱 실패: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }

    func updateDistances(from userLocation: CLLocation) {
        for index in stores.indices {
            let storeLocation = CLLocation(latitude: stores[index].latitude, longitude: stores[index].longitude)
            let distance = userLocation.distance(from: storeLocation) / 1000.0
            stores[index].distance = distance
        }

        stores.sort {
            ($0.distance ?? Double.infinity) < ($1.distance ?? Double.infinity)
        }
    }
}
