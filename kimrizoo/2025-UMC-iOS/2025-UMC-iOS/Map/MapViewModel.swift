import Foundation
import Moya
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
    
    private var kakaoProvider = MoyaProvider<KakaoAPI>()
    private let googleProvider = MoyaProvider<GooglePlaceAPI>()
    
    // 마커
    var makers: [Marker] = []
    
    init() {
        updateCurrentLocationText()
    }
    
    @MainActor
    func loadInitialData() async {
        await loadAndFilterNearbyStores()
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

    // 가까운 가게 로드
    @MainActor
    func loadAndFilterNearbyStores() async {
        guard let userLocation = locationManager.currentLocation else {
            nearbyStores = []
            return
        }

        do {
            let storeCollection = try await withCheckedThrowingContinuation { continuation in
                parsingViewModel.loadStarbucks { result in
                    switch result {
                    case .success(let storeCollection):
                        continuation.resume(returning: storeCollection)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }

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

                async let addressTask = geoCoderManager.reverseGeocode(coordinate: coord)
                async let photoTask = fetchPhotoReferences(for: props.storeName)

                let (address, photoRefs) = await (addressTask, photoTask)
                let photoRef = photoRefs.first

                let storeDisplay = StoreDisplayInfo(
                    name: props.storeName,
                    distance: String(format: "%.2fkm", distance / 1000),
                    tagSymbol: [props.categoryTag.tagSymbol],
                    address: address ?? "주소 없음",
                    photoReference: photoRef
                )

                displayStores.append(storeDisplay)
                newMarkers.append(Marker(coordinate: coord, title: props.storeName))
            }

            nearbyStores = displayStores.sorted { $0.distance < $1.distance }
            makers = newMarkers

        } catch {
            nearbyStores = []
            makers = []
            print("❌ 매장 불러오기 실패: \(error.localizedDescription)")
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
    @MainActor
    func searchStoresNearMapCenter() async {
        guard let center = currentMapCenter else { return }

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
                
                let photoRefs = await fetchPhotoReferences(for: props.storeName)
                let photoRef = photoRefs.first

                let storeDisplay = StoreDisplayInfo(
                    name: props.storeName,
                    distance: String(format: "%.2fkm", distance / 1000),
                    tagSymbol: [props.categoryTag.tagSymbol],
                    address: address,
                    photoReference: photoRef
                )

                displayStores.append(storeDisplay)
                newMarkers.append(Marker(coordinate: coord, title: props.storeName))
            }

            self.nearbyStores = displayStores
            self.makers = newMarkers
            self.isMapMovedByUser = false

        case .failure(let error):
            print("검색 에러: \(error.localizedDescription)")
        }
    }

    
    // MARK: - 현재 위치 역지오코딩
    func getCurrentAddress() async -> String {
        guard let location = locationManager.currentLocation else {
            return "❌ 위치를 가져올 수 없습니다"
          }
          
          let address = await geoCoderManager.reverseGeocode(coordinate: location.coordinate)
          return address ?? "❌ 주소를 가져올 수 없습니다"
    }
    
    // MARK: - 카카오 키워드 검색 함수
    func searchPlaces(by keyword: String, completion: @escaping ([KakaoPlace]) -> Void) {
        guard let location = locationManager.currentLocation else {
            print("❌ currentLocation이 nil입니다.")
            completion([])
            return
        }

        print("🔍 검색 시작: \(keyword), 위치: \(location.coordinate)")

        kakaoProvider.request(.keywordSearch(query: keyword, center: location.coordinate)) { result in
            switch result {
            case .success(let response):
                if let raw = String(data: response.data, encoding: .utf8) {
                    print("📦 응답 원문: \(raw)")
                }
                do {
                    let decoded = try JSONDecoder().decode(KakaoPlaceResponse.self, from: response.data)
                    print("✅ 검색 성공: \(decoded.documents.count)개 결과")
                    completion(decoded.documents)
                } catch {
                    print("❌ JSON 파싱 실패: \(error)")
                    completion([])
                }
            case .failure(let error):
                print("❌ 카카오 API 요청 실패: \(error)")
                completion([])
            }
        }
    }

    // MARK: - 키워드 도착지 검색 함수
    func searchArrivalStores(by keyword: String, completion: @escaping ([KakaoPlace]) -> Void) {
        parsingViewModel.loadStarbucks { result in
            switch result {
            case .success(let storeCollection):
                let matches = storeCollection.features
                    .map { $0.properties }
                    .filter { $0.storeName.contains(keyword) }
                    .map {
                        KakaoPlace(
                            placeName: $0.storeName,
                            addressName: $0.address
                        )
                    }

                completion(matches)

            case .failure(let error):
                print("❌ 도착지 검색 실패: \(error.localizedDescription)")
                completion([])
            }
        }
    }
    
    // MARK: - Google Place API에서 photo_reference 추출
    @MainActor
    func fetchPhotoReferences(for storeName: String) async -> [String] {
        let query = "\(storeName) 스타벅스"
        do {
            let response = try await withCheckedThrowingContinuation { continuation in
                googleProvider.request(.searchPlace(query: query)) { result in
                    switch result {
                    case .success(let response):
                        continuation.resume(returning: response)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            }

            let decoded = try JSONDecoder().decode(GooglePlaceResponse.self, from: response.data)
            let references = decoded.results.compactMap { $0.photos?.first?.photo_reference }
            return references
        } catch {
            print("❌ photo_reference 파싱 실패: \(error)")
            return []
        }
    }
    
    func photoURL(from reference: String) -> URL? {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_PLACES_API_KEY") as? String ?? ""
        let urlString = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=\(reference)&key=\(apiKey)"
        return URL(string: urlString)
    }
}
