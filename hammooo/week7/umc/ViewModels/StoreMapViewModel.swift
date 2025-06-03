
import Foundation
import MapKit
import SwiftUI

enum StoreMapSegment: String, CaseIterable {
    case store = "매장 찾기"
    case direction = "길찾기"
}

class StoreMapViewModel: ObservableObject {
    @Published var selectedSegment: StoreMapSegment = .store

    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    @Published var stores: [Store] = []

    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)

    init() {
        loadGeoJSON()
   
    }

    func moveToCurrentLocation() {
        LocationManager.shared.startUpdatingLocation()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            guard let location = LocationManager.shared.currentLocation else { return }
            self.region.center = location.coordinate
            LocationManager.shared.stopUpdatingLocation()
        }
    }

    func loadGeoJSON() {
        guard let data = loadGeoJSONFile(named: "starbucks_2025") else { return }

        Task {
            do {
                let features = try decodeGeoJSONFeatures(from: data)
                var loadedStores: [Store] = []

                for feature in features {
                    if var store = parseStore(from: feature) {
                        let photoRef = await fetchPhotoReference(for: store.name)
                        store.photoReference = photoRef
                        loadedStores.append(store)
                    }
                }

                DispatchQueue.main.async {
                    print("불러온 매장 수: \(loadedStores.count)")
                    self.stores = loadedStores
                }

            } catch {
                print("GeoJSON 파싱 실패: \(error.localizedDescription)")
            }
        }
    }

    
    
    
    func fetchPhotoReference(for query: String) async -> String? {
        let provider = APIManager.shared.createProvider(for: GooglePlaceAPI.self)

        return await withCheckedContinuation { continuation in
            provider.request(.textSearch(query: query)) { result in
                switch result {
                case .success(let response):
                    do {
                        let json = try JSONSerialization.jsonObject(with: response.data) as? [String: Any]
                        
                        let photoRef = (((json?["results"] as? [[String: Any]])?.first)?["photos"] as? [[String: Any]])?.first?["photo_reference"] as? String
                        continuation.resume(returning: photoRef)
                    } catch {
                        continuation.resume(returning: nil)
                    }
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
        }
    }



    // MARK: - 헬퍼 함수

    private func loadGeoJSONFile(named name: String) -> Data? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "geojson"),
              let data = try? Data(contentsOf: url) else {
            print("GeoJSON 파일을 불러올 수 없습니다.")
            return nil
        }
        return data
    }

    private func decodeGeoJSONFeatures(from data: Data) throws -> [MKGeoJSONFeature] {
        let objects = try MKGeoJSONDecoder().decode(data)
        return objects.compactMap { $0 as? MKGeoJSONFeature }
    }

    private func parseStore(from feature: MKGeoJSONFeature) -> Store? {
        guard let point = feature.geometry.first as? MKShape & MKGeoJSONObject else { return nil }
        guard let propertiesData = feature.properties,
              let json = try? JSONSerialization.jsonObject(with: propertiesData) as? [String: Any],
              let name = json["Sotre_nm"] as? String,
              let address = json["Address"] as? String else {
            return nil
        }

        let coordinate = point.coordinate
        let category = parseCategory(from: json["Category"] as? String ?? "")
        let imageName = "starbucks_pin"

        return Store(
            name: name,
            latitude: coordinate.latitude,
            longitude: coordinate.longitude,
            category: category,
            imageName: imageName,
            address: address
        )

    }

    private func parseCategory(from raw: String) -> StoreCategory {
        switch raw {
        case "리저브 매장":
            return .reserve
        case "드라이브 스루":
            return .dt
        default:
            return .normal
        }
    }
}















//App 시작 → StoreMapViewModel 초기화 → loadGeoJSON() 호출
//    → GeoJSON 파싱 → 각 매장 이름으로 GooglePlaceAPI 호출
//        → photo_reference 응답 → Store에 저장
//            → 뷰에서 KFImage(store.googlePhotoURL)로 이미지 표시
//
//
//















//import Foundation
//import MapKit
//import SwiftUI
//
//
//enum StoreMapSegment: String, CaseIterable {
//    case store = "매장 찾기"
//    case direction = "길찾기"
//}
//
//class StoreMapViewModel: ObservableObject {
//    @Published var selectedSegment: StoreMapSegment = .store
//    
//    @Published var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780),
//        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
//    
//    @Published var stores: [Store] = []
//    
//    @Published var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
//    
//    init() {
//        loadGeoJSON()
//    }
//    
//    func moveToCurrentLocation() {
//        LocationManager.shared.startUpdatingLocation()
//        
//        // 0.5초 후 현재 위치가 업데이트됐을 것으로 가정하고 region 갱신
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            guard let location = LocationManager.shared.currentLocation else { return }
//            self.region.center = location.coordinate
//            LocationManager.shared.stopUpdatingLocation()
//        }
//    }
//    
//    func loadGeoJSON() {
//        guard let data = loadGeoJSONFile(named: "starbucks_2025") else { return }
//        
//        do {
//            let features = try decodeGeoJSONFeatures(from: data)
//            let loadedStores = features.compactMap { parseStore(from: $0) }
//            
//            DispatchQueue.main.async {
//                print("불러온 매장 수: \(loadedStores.count)")
//                self.stores = loadedStores
//            }
//        } catch {
//            print("GeoJSON 파싱 실패: \(error.localizedDescription)")
//        }
//    }
//    
// 
//
//    
//    // MARK: - 헬퍼 함수
//    
//    private func loadGeoJSONFile(named name: String) -> Data? {
//        guard let url = Bundle.main.url(forResource: name, withExtension: "geojson"),
//              let data = try? Data(contentsOf: url) else {
//            print("GeoJSON 파일을 불러올 수 없습니다.")
//            return nil
//        }
//        return data
//    }
//    
//    private func decodeGeoJSONFeatures(from data: Data) throws -> [MKGeoJSONFeature] {
//        let objects = try MKGeoJSONDecoder().decode(data)
//        return objects.compactMap { $0 as? MKGeoJSONFeature }
//    }
//    
//    private func parseStore(from feature: MKGeoJSONFeature) -> Store? {
//        guard let point = feature.geometry.first as? MKShape & MKGeoJSONObject else { return nil }
//        guard let propertiesData = feature.properties,
//              let json = try? JSONSerialization.jsonObject(with: propertiesData) as? [String: Any],
//              let name = json["Sotre_nm"] as? String,
//              let address = json["Address"] as? String else {
//            return nil
//        }
//        
//        let coordinate = point.coordinate
//        let category = parseCategory(from: json["Category"] as? String ?? "")
//        let imageName = "starbucks_pin"
//        
//        return Store(
//            name: name,
//            latitude: coordinate.latitude,
//            longitude: coordinate.longitude,
//            category: category,
//            imageName: imageName,
//            address: address
//        )
//    }
//    
//    private func parseCategory(from raw: String) -> StoreCategory {
//        switch raw {
//        case "리저브 매장":
//            return .reserve
//        case "드라이브 스루":
//            return .dt
//        default:
//            return .normal
//        }
//    }
//}
//
//








