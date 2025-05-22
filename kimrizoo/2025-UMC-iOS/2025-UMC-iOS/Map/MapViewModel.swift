import Foundation
import CoreLocation

@Observable
class MapViewModel {
    let locationManager = LocationManager.shared
    let parsingViewModel = JSONParsingViewModel()
    let geoCoderManager = GeoCoderManager()

    var currentLocationText: String = "위치 불러오는 중..."
    var currentAddressText: String = "주소 불러오는 중..."
    var nearbyStores: [StoreDisplayInfo] = []

    init() {
        updateCurrentLocationText()
        loadAndFilterNearbyStores()
    }

    func updateCurrentLocationText() {
        guard let location = locationManager.currentLocation else {
            currentLocationText = "❌ 현재 위치를 가져올 수 없습니다."
            return
        }

        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        currentLocationText = "📍 현재 위치: \(latitude), \(longitude)"
    }

    func loadAndFilterNearbyStores() {
        Task {
            let userLocation = locationManager.currentLocation
            guard let userLocation = userLocation else {
                nearbyStores = []
                return
            }

            let result = await withCheckedContinuation { continuation in
                parsingViewModel.loadStarbucks { result in
                    continuation.resume(returning: result)
                }
            }

            switch result {
            case .success(let storeCollection):
                var displayStores: [StoreDisplayInfo] = []

                for feature in storeCollection.features {
                    let props = feature.properties
                    let lat = props.yCoordinate
                    let lon = props.xCoordinate
                    let storeLocation = CLLocation(latitude: lat, longitude: lon)
                    let distance = userLocation.distance(from: storeLocation)

                    guard distance <= 10000 else { continue }

                    // 역지오코딩 실행
                    let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    let address = await geoCoderManager.reverseGeocode(coordinate: coord) ?? "주소 없음"

                    let formattedDistance = String(format: "%.2fkm", distance / 1000)
                    let tagSymbol = props.categoryTag.tagSymbol
                    let tagList = tagSymbol.isEmpty ? [] : [tagSymbol]

                    let storeDisplay = StoreDisplayInfo(
                        name: props.storeName,
                        distance: formattedDistance,
                        tagSymbol: tagList,
                        address: address
                    )

                    displayStores.append(storeDisplay)
                }

                // 거리순 정렬
                nearbyStores = displayStores.sorted { $0.distance < $1.distance }

            case .failure(let error):
                nearbyStores = []
                print("에러: \(error.localizedDescription)")
            }
        }
    }
}
