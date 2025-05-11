//
//  Geo_ReverseGeo.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/3/25.
//

import SwiftUI
import CoreLocation

struct Geo_ReverseGeo: View {
    @State private var address: String = "주소 불러오는 중..."
    var body: some View {
        Text(address)
            .padding()
            .task {
                let geocoder = CLGeocoder()
                let addressString = "서울특별시 종로구"

                do {
                    let placemarks = try await geocoder.geocodeAddressString(addressString)
                    if let location = placemarks.first?.location {
                        print("위도: \(location.coordinate.latitude), 경도: \(location.coordinate.longitude)")
                    }
                } catch {
                    print("지오코딩 에러: \(error.localizedDescription)")
                }

                let location = CLLocation(latitude: 37.579617, longitude: 126.977041)

                do {
                    let placemarks = try await geocoder.reverseGeocodeLocation(location)
                    if let placemark = placemarks.first {
                        let address = [
                            placemark.administrativeArea,
                            placemark.locality,
                            placemark.subLocality,
                            placemark.thoroughfare
                        ].compactMap { $0 }.joined(separator: " ")

                        self.address = address
                    }
                } catch {
                    self.address = "주소 변환 실패: \(error.localizedDescription)"
                }
            }
    }
}

#Preview {
    Geo_ReverseGeo()
}
