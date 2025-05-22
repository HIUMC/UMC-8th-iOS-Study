import Foundation
import _MapKit_SwiftUI
import CoreLocation
import MapKit

@Observable
class MapViewModel {
    
    // MARK: - 변수
    let locationManager = LocationManager.shared
    let parsingViewModel = JSONParsingViewModel()
    let geoCoderManager = GeoCoderManager()

    var currentLocationText: String = "위치 불러오는 중..."
    var currentAddressText: String = "주소 불러오는 중..."
    var nearbyStores: [StoreDisplayInfo] = []

    var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    var currentMapCenter: CLLocationCoordinate2D?
    
    var isMapMovedByUser: Bool = false  // 지도 드래그 감지
    var hasInitializedCamera: Bool = false
    
    // 마커
    var makers: [Marker] = []
    
    init() {
        updateCurrentLocationText()
        loadAndFilterNearbyStores()
    }

    // MARK: - 함수 for 가게 리스트
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
                var newMarkers: [Marker] = []

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
                    
                    // 가게의 마커를 추가한다.
                    let marker = Marker(coordinate: coord, title: props.storeName)
                    newMarkers.append(marker)
                }

                // 거리순 정렬
                nearbyStores = displayStores.sorted { $0.distance < $1.distance }
                makers = newMarkers

            case .failure(let error):
                nearbyStores = []
                makers = []
                print("에러: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - 지도 관련 함수
    func updateFromLocation(_ location: CLLocation?) {
        guard let location = location else { return }

        // 현재 위치 중심으로 카메라 이동
        self.cameraPosition = .region(MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))

        self.currentMapCenter = location.coordinate
        self.isMapMovedByUser = false // 초기 진입이므로 드래그 아님
    }
    
    // 드래그 시 재검색 함수
    func searchStoresNearMapCenter() {
            guard let center = currentMapCenter else { return }

            Task {
                let userLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
                let result = await withCheckedContinuation { continuation in
                    parsingViewModel.loadStarbucks { result in
                        continuation.resume(returning: result)
                    }
                }

                switch result {
                case .success(let storeCollection):
                    var displayStores: [StoreDisplayInfo] = []
                    var newMarkers: [Marker] = []

                    for feature in storeCollection.features {
                        let props = feature.properties
                        let lat = props.yCoordinate
                        let lon = props.xCoordinate
                        let storeLocation = CLLocation(latitude: lat, longitude: lon)
                        let distance = userLocation.distance(from: storeLocation)

                        guard distance <= 10_000 else { continue }

                        let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                        let address = await geoCoderManager.reverseGeocode(coordinate: coord) ?? "주소 없음"

                        let storeDisplay = StoreDisplayInfo(
                            name: props.storeName,
                            distance: String(format: "%.2fkm", distance / 1000),
                            tagSymbol: [props.categoryTag.tagSymbol],
                            address: address
                        )

                        displayStores.append(storeDisplay)
                        newMarkers.append(Marker(coordinate: coord, title: props.storeName))
                    }

                    self.nearbyStores = displayStores
                    self.makers = newMarkers
                    self.isMapMovedByUser = false  // 검색 후 비활성화

                case .failure(let error):
                    print("검색 에러: \(error.localizedDescription)")
                }
            }
        }
}
