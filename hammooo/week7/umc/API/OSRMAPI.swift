import Foundation
import Moya
import MapKit



enum OSRMAPI: TargetType {
    case route(from: CLLocationCoordinate2D, to: CLLocationCoordinate2D)

    var baseURL: URL {
      
        return URL(string: Config.baseURL)!
    }

    var path: String {
        switch self {
        case let .route(from, to):
            return "/route/v1/foot/\(from.longitude),\(from.latitude);\(to.longitude),\(to.latitude)"
        }
    }

    var method: Moya.Method { .get }

    var task: Task {
        .requestParameters(parameters: [
            "overview": "full",
            "geometries": "geojson"
        ], encoding: URLEncoding.queryString)
    }

    var headers: [String : String]? { nil }

    var sampleData: Data {
        // 아래 2번 항목 참고!
        try! JSONEncoder().encode(GeoJSONRoute.sample)
    }
}




struct GeoJSONRoute: Codable {
    let routes: [Route]

    struct Route: Codable {
        let geometry: Geometry
    }

    struct Geometry: Codable {
        let coordinates: [[Double]]  // [longitude, latitude]
    }

    static let sample: GeoJSONRoute = .init(routes: [
        .init(geometry: .init(coordinates: [
            [127.0321, 37.5631],
            [127.0331, 37.5641],
            [127.0341, 37.5651]
        ]))
    ])
}
