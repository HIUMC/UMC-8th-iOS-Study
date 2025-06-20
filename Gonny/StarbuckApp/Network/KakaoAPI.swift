//
//  Router.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/20/25.
//
/*
 구글 API-> 각 매장마다 서버에 저장되어있는 이미지 불러오기, 이미지를 나타내는 URL도 받아오기
 각 StoreCell에 매장 사진을 받아올 수 있도록
 킹피셔 -> 자동으로 파싱되기 때문에 따로 관리해줄 필요는 없을 듯
 네트워크 요청이 너무 많이 들어갈 수도 있잖아-> 이미지url이 nil 이면
 
 */
import Moya
import Foundation
import CoreLocation

enum KakaoAPI {
    case keywordSearch(query: String, coordinate: CLLocationCoordinate2D)
}

extension KakaoAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://dapi.kakao.com")!
    }

    
    //현재 위치의 case도 포함할 것!!
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
            case .keywordSearch(let query, let coordinate):
                return .requestParameters(parameters: [
                    "query": query,
                    "x": coordinate.longitude,
                    "y": coordinate.latitude,
                    "radius": 5,
                    "page": 1,
                    "size": 15
                ], encoding: URLEncoding.queryString)
            }
        }
    

    var headers: [String : String]? {
            let key = Bundle.main.infoDictionary?["KAKAO_REST_API_KEY"] as? String ?? ""
            //let authorizationHeader = "KakaoAK \(key)"
            return ["Authorization": "KakaoAK a49b5fbb75b77d621e5e3b0680b5f321"]
        }

        var sampleData: Data {
            return Data()
        }
}

struct FindRouteModel{
    var 
}
