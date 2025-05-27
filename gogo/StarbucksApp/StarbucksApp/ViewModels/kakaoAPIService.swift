//
//  kakaoAPIService.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/28/25.
//

import Foundation
import Alamofire
import Moya

final class KakaoAPIService {
    static let shared = KakaoAPIService()
    private let provider = MoyaProvider<KakaoAPI>()

    private init() {}

    func searchKeyword(query: String, completion: @escaping (Result<FindStoreModel, Error>) -> Void) {
        provider.request(.searchKeyword(query: query)) { result in
            switch result {
            case .success(let response):
                do {
                    let filtered = try response.filterSuccessfulStatusCodes()
                    let store = try JSONDecoder().decode(FindStoreModel.self, from: filtered.data)
                    completion(.success(store))
                } catch {
                    print("❌ 디코딩 실패 또는 상태 코드 오류: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum KakaoAPI {
    case searchKeyword(query: String)
}

extension KakaoAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }

    var path: String {
        switch self {
        case .searchKeyword:
            return "/v2/local/search/keyword.json"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        switch self {
        case .searchKeyword(let query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_REST_API_KEY") as? String else {
            return nil
        }
        return ["Authorization": "KakaoAK \(apiKey)"]
    }

    var sampleData: Data {
        return Data()
    }
}
