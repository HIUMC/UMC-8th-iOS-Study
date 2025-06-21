//
//  ImageAPI.swift
//  StarbuckApp
//
//  Created by 박병선 on 6/21/25.
//
import Moya
import Foundation

enum ImageAPI {
    case generateImage(request: Txt2ImgRequest)
}

extension ImageAPI: TargetType {
    var baseURL: URL { URL(string: Config.imageURL)! }
    
    var path: String {
        switch self {
        case .generateImage:
            return "/sdapi/v1/txt2img"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .generateImage:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .generateImage(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String: String]? {
        ["Content-Type": "application/json"]
    }
    
   // var sampleData: Data { Data() }
}
