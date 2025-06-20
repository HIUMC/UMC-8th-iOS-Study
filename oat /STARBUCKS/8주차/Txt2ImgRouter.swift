//
//  Txt2ImgRouter.swift
//  STARBUCKS
//
//  Created by 신민정 on 6/17/25.
//

import Foundation
import Moya

enum Txt2ImgRouter {
    case generateImage(request: Txt2ImgRequest)
    case checkProgress
}

extension Txt2ImgRouter: TargetType {
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:7860")!
    }

    var path: String {
        switch self {
        case .generateImage:
            return "/sdapi/v1/txt2img"
        case .checkProgress:
            return "/sdapi/v1/progress"
        }
    }

    var method: Moya.Method {
        switch self {
        case .generateImage:
            return .post
        case .checkProgress:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .generateImage(let request):
            return .requestJSONEncodable(request)
        case .checkProgress:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }
}

