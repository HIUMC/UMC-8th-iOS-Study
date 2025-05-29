import Foundation
import Moya

// MARK: - BaseTarget Protocol

protocol BaseTarget: TargetType {}

extension BaseTarget {
    var baseURL: URL {
        let urlString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
        return URL(string: urlString)!
    }

    var headers: [String: String]? {
        switch task {
        case .requestJSONEncodable, .requestParameters:
            return [
                "Content-Type": "application/json",
                "API_KEY": Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
            ]
        case .uploadMultipart:
            return [
                "Content-Type": "multipart/form-data",
                "API_KEY": Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
            ]
        default:
            return nil
        }
    }
}

// MARK: - OSRMAPI Enum

enum OSRMAPI {
    case 케이스이름1
    case 케이스이름2
}

// MARK: - OSRMAPI TargetType Implementation

extension OSRMAPI: BaseTarget {
    var path: String {
        switch self {
        case .케이스이름1: return "path1"
        case .케이스이름2: return "path2"
        }
    }

    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case .케이스이름1:
            return .requestParameters(
                parameters: ["파라미터1": "값1", "파라미터2": 123],
                encoding: JSONEncoding.default
            )
        case .케이스이름2:
            return .requestParameters(
                parameters: ["파라미터1": "다른값", "파라미터2": 456],
                encoding: JSONEncoding.default
            )
        }
    }

    var sampleData: Data {
        return "{\"message\": \"Hello, world!\"}".data(using: .utf8)!
    }
}
