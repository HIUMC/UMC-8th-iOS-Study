import Foundation
import CoreLocation

@Observable
class GeoCoderManager {
    
    private let geocoder = CLGeocoder()
    
    // MARK: - 지오코딩
    func geocode(addressString: String) async -> CLLocationCoordinate2D? {
        do {
            let placemarks = try await geocoder.geocodeAddressString(addressString)
            if let location = placemarks.first?.location {
                let coord = location.coordinate
                print("위도: \(coord.latitude), 경도: \(coord.longitude)")
                return coord
            }
        } catch {
            print("지오코딩 에러: \(error.localizedDescription)")
        }
        return nil
    }
    
    // MARK: - 역지오코딩
    func reverseGeocode(coordinate: CLLocationCoordinate2D) async -> String? {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let administrativeArea = placemark.administrativeArea ?? ""     // ex. 서울특별시
                let subLocality = placemark.subLocality ?? ""                   // ex. 동교동
                let thoroughfare = placemark.thoroughfare ?? ""                 // ex. 동교동 or 양화로
                let subThoroughfare = placemark.subThoroughfare ?? ""           // ex. 166-1

                // ✅ 중복 제거 (예: thoroughfare == subLocality인 경우 제거)
                let useThoroughfare = (thoroughfare != subLocality) ? thoroughfare : ""
                
                let detailAddress = [useThoroughfare, subThoroughfare]
                    .filter { !$0.isEmpty }
                    .joined(separator: " ")

                // ✅ 최종 주소: 서울특별시 동교동 166-1
                let fullAddress = "\(administrativeArea) \(subLocality) \(detailAddress)"
                    .trimmingCharacters(in: .whitespaces)

                print("주소: \(fullAddress)")
                return fullAddress
            }
        } catch {
            print("역지오코딩 에러: \(error.localizedDescription)")
        }

        return nil
    }



}
