import Moya
import CoreLocation

enum KakaoAPI {
    case keywordSearch(query: String, center: CLLocationCoordinate2D)
}

extension KakaoAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }

    var path: String {
        switch self {
        case .keywordSearch:
            return "/v2/local/search/keyword.json"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .keywordSearch(let query, let center):
            let params: [String: Any] = [
                "query": query,
                "x": center.longitude,
                "y": center.latitude,
                "radius": 5000,
                "page": 1,
                "size": 15
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Authorization": "KakaoAK \(Bundle.main.object(forInfoDictionaryKey: "KAKAO_REST_API_KEY") as? String ?? "")"]
    }

    var sampleData: Data {
        return Data()
    }
}
