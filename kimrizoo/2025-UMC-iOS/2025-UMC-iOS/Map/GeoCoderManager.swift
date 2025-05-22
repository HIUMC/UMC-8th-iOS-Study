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
                let address = [
                    placemark.administrativeArea,
                    placemark.locality,
                    placemark.subLocality,
                    placemark.thoroughfare
                ].compactMap { $0 }.joined(separator: " ") // ← 오타: seperator → separator

                print("주소: \(address)")
                return address
            }
        } catch {
            print("역지오코딩 에러: \(error.localizedDescription)")
        }

        return nil
    }
}
