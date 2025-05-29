import Foundation
import Moya
import CoreLocation

// MARK: - Kakao API
enum KakaoAPI {
    case keywordSearch(query: String, center: CLLocationCoordinate2D)
}

extension KakaoAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }

    var path: String {
        return "/v2/local/search/keyword.json"
    }

    var method: Moya.Method { .get }

    var task: Task {
        switch self {
        case .keywordSearch(let query, let center):
            return .requestParameters(
                parameters: [
                    "query": query,
                    "x": center.longitude,
                    "y": center.latitude,
                    "radius": 5000,
                    "page": 1,
                    "size": 15
                ],
                encoding: URLEncoding.default
            )
        }
    }

    var headers: [String: String]? {
        return [
            "Authorization": "KakaoAK \(Bundle.main.object(forInfoDictionaryKey: "KAKAO_REST_API_KEY") as? String ?? "")"
        ]
    }

    var sampleData: Data { Data() }
}

// MARK: - Google Places API
enum GooglePlaceAPI {
    case searchPlace(query: String)
}

extension GooglePlaceAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://maps.googleapis.com/maps/api/place")!
    }

    var path: String {
        return "/textsearch/json"
    }

    var method: Moya.Method { .get }

    var task: Task {
        switch self {
        case .searchPlace(let query):
            return .requestParameters(
                parameters: [
                    "query": query,
                    "key": Bundle.main.object(forInfoDictionaryKey: "GOOGLE_PLACES_API_KEY") as? String ?? ""
                ],
                encoding: URLEncoding.default
            )
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data { Data() }
}
