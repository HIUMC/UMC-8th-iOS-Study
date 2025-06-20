//
//  AIImageTarget.swift
//  Starbucks_project
//
//  Created by Yoonseo on 6/19/25.
//

import Foundation
import Moya

enum AIImageTarget {
    case generateImage(request: Txt2ImgRequest)
    case checkProgress
}

extension AIImageTarget: TargetType {
    var baseURL: URL {
        guard let urlString = Bundle.main.infoDictionary?["Image_URL"] as? String,
              let url = URL(string: urlString) else {
            fatalError("❌ 'Image_URL' not found or invalid in Info.plist")
        }
        return url
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
        case let .generateImage(request):
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
