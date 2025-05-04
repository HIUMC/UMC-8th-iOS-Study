 //StarbucksStoreModel

import CoreLocation

struct StarbucksStoreModel:Codable {
    var features: [StoreFeature]
}

struct StoreFeature:Codable,Hashable {
    var properties: StoreProperty
    let geometry: Geometry
}

struct StoreProperty: Codable,Hashable {
    let storeId: String
    let storeName: String
    let address: String
    let telephone: String
    let category: StoreCategory
    let yCoordinate: Double
    let xCoordinate: Double
    
    
    
    var resolvedAddress: String? = nil
    
    enum CodingKeys: String, CodingKey {
        case storeId = "Seq"
        case storeName = "Store_nm"
        case address = "Address"
        case telephone = "Telephone"
        case category = "Category"
        case yCoordinate = "Ycoordinate"
        case xCoordinate = "Xcoordinate"
        
    }
}


struct Geometry : Codable, Hashable {
    let type: String
    let coordinates: [Double]
}

enum StoreCategory : String, Codable {
    case none = ""
    case reserve = "리저브 매장"
    case dt = "DT 매장"
}

struct Marker : Identifiable {
    let id = UUID()
    let coordinate : CLLocationCoordinate2D
    let title: String
}



//import Foundation
//import CoreLocation
//
//@Observable
//class JSONParsingViewModel {
//    var storeData: StarbucksStoreModel?
//
//    func loadStoreData(completion: @escaping (Result<StarbucksStoreModel, Error>) -> Void) {
//        Task {
//            do {
//                // JSON 파일 경로 찾기
//                guard let url = Bundle.main.url(forResource: "stores", withExtension: "geojson") else {
//                    print("json 파일 없음")
//                    completion(.failure(NSError(domain: "파일 못찾았어요!", code: 404, userInfo: nil)))
//                    return
//                }
//
//                // JSON 파일에서 데이터 읽기
//                let data = try Data(contentsOf: url)
//                
//                // 디코딩
//                let decoded = try JSONDecoder().decode(StarbucksStoreModel.self, from: data)
//                print("디코딩 성공")
//                
//                // 주소 해석 (옵션)
//                // let resolvedFeatures = await self.resolveAddresses(for: decoded.features)
//                // decoded.features = resolvedFeatures
//                
//                // 상태에 저장
//                self.storeData = decoded
//                // print("주소 반영 성공")
//
//                completion(.success(decoded)) // 이제 완성된 decoded를 넘긴다!
//            } catch {
//                print("디코딩 실패: \(error.localizedDescription)")
//                completion(.failure(error))
//            }
//        }
//    }
//
//    func resolveAddresses(for features: [StoreFeature]) async -> [StoreFeature] {
//        var updatedFeatures = features
//        let geocoder = CLGeocoder()
//
//        let limitedFeatures = Array(features.prefix(10)) // 앞에서 10개만
//
//        for (index, feature) in limitedFeatures.enumerated() {
//            let location = CLLocation(latitude: feature.properties.yCoordinate,
//                                      longitude: feature.properties.xCoordinate)
//
//            do {
//                let placemarks = try await geocoder.reverseGeocodeLocation(location)
//                if let placemark = placemarks.first {
//                    var newFeature = feature
//                    newFeature.properties.resolvedAddress = placemark.compactAddress
//                    updatedFeatures[index] = newFeature
//                }
//            } catch {
//                print("역지오코딩 실패: \(error.localizedDescription)")
//            }
//        }
//
//        return updatedFeatures
//    }
//}
//
//extension CLPlacemark {
//    var compactAddress: String? {
//        if let name = name {
//            var result = name
//
//            if let city = locality {
//                result += ", \(city)"
//            }
//
//            if let country = country {
//                result += ", \(country)"
//            }
//
//            return result
//        }
//        return nil
//    }
//}




