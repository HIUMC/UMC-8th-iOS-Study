//
//  Txt2ImgService.swift
//  STARBUCKS
//
//  Created by 신민정 on 6/17/25.
//

import Foundation
import Moya
import Combine
import CombineMoya

final class Txt2ImgService {
    static let shared = Txt2ImgService()
    private let provider = MoyaProvider<Txt2ImgRouter>()

    func generateImage(request: Txt2ImgRequest) -> AnyPublisher<Txt2ImgImageOnlyResponse, Error> {
        provider.requestPublisher(.generateImage(request: request))
            .map(\.data)
            .decode(type: Txt2ImgImageOnlyResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func checkProgress() -> AnyPublisher<Double, Error> {
        provider.requestPublisher(.checkProgress)
            .map(\.data)
            .decode(type: ProgressResponse.self, decoder: JSONDecoder())
            .map { $0.progress } 
            .eraseToAnyPublisher()
    }
}


struct ProgressResponse: Decodable {
    let progress: Double
}
