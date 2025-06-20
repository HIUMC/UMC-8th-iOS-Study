//
//  Untitled.swift
//  7th_Practice
//
//  Created by 박병선 on 5/26/25.
//
import Foundation
import Moya
import SwiftData

protocol BaseTarget: TargetType {}

extension BaseTarget {
    var baseURL: URL {
        return URL(string: "https://블라블라.com")!
    }
}




//AuthAPI는 API의 종류(로그인, 회원가입 등)를 case로 표현하는 열거형
//각 case는 요청에 필요한 파라미터(email,password 등)를 associated value로 갖고 있음
enum AuthAPI {
    case login(email: String, password: String)
    case signup(name: String, email: String, password: String)
}

//BaseTarget을 체택했기 때문에 baseURL은 따로 정의하지 않아도 자동으로 제공됨
extension AuthAPI: BaseTarget {
    
    //각 API요펑의 URL경로(path)를 설정함, 전체 URL은 baseURL+path로 조합됨
    var path: String {
        switch self {
        case .login: 
            return "/auth/login"
        case .signup: 
            return "/auth/signup"
        }
    }
    
    //HTTP 메서드 정의(로그인과 회원가입은 POST 방식)
    var method: Moya.Method {
        return .post
    }
    
    //실제로 서버에 보내는 요청 바디를 정의함
    //.requestParameters는 딕셔너리 형태(key-value)로 파라미터를 담고, JSONEncoding.default는 application/json 형채로 인코딩
    var task: Task {
        switch self {
        case let .login(email, password):
            return .requestParameters(
                parameters: ["email": email, "password": password],
                encoding: JSONEncoding.default
            )
            
        case let .signup(name, email, password):
            return .requestParameters(
                parameters: ["name": name, "email": email, "password": password],
                encoding: JSONEncoding.default
            )
        }
    }

    //HTTP헤더를 정의, 일반적으로 JSON API는 Content-Type을 application/json으로 설정
    //각 API별로 headers를 직접 정의하지 않아도 상황에 맞게 자동 적용됨
    var headers: [String: String]? {
            switch task {
            case .requestJSONEncodable, .requestParameters:
                return ["Content-Type": "application/json"]
            case .uploadMultipart:
                return ["Content-Type": "multipart/form-data"]
            default:
                return nil
            }
        }
    /*
     Content-Type: HTTP 요청/응답 바디가 어떤 형식인지 나타내는 헤더필드
     ex. Content-Type: application/json
     -> 의미: 내가 보내는 데이터는 JSON 형식임
     ex. Content-Type: text/html
     -> 이건 HTML 문서, 주로 브라우저에서 HTML 페이지 받을 때 사용됨
     ex. Content-Type: multipart/form-data
     -> 이 요청에는 여러 데이터가 섞여 있음
     */
    
    //필수적인 것은 아님
    var sampleData: Data {
        return "{\"message\": \"Hello, world!\"}".data(using: .utf8)!
    }
}

