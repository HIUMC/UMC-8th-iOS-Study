//
//  ImageServiceManager.swift
//  StarbuckApp
//
//  Created by 박병선 on 6/20/25.
//
import Foundation
import Combine
import Moya
import CombineMoya
import UIKit

final class ImageServiceManager {
    static let shared = ImageServiceManager()
    private init() {}
    
    private let provider = MoyaProvider<ImageAPI>()
    
    func generateImage(prompt: String, negativePrompt: String) -> AnyPublisher<UIImage?, Error> {
        let request = Txt2ImgRequest(prompt: prompt, negativePrompt: negativePrompt)
        
        return provider.requestPublisher(.generateImage(request: request))
            .map(\.data)
            .decode(type: Txt2ImgImageOnlyResponse.self, decoder: JSONDecoder())
            .map { response in
                guard let base64 = response.images.first,
                      let data = Data(base64Encoded: base64),
                      let image = UIImage(data: data) else {
                    print("이미지 디코딩 실패")
                    return nil
                }
                return image
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}

/*
import Foundation
import Alamofire
import UIKit

final class ImageServiceManager {
    static let shared = ImageServiceManager()

    private init() {}

    private let baseURL = "\(Config.imageURL)/sdapi/v1/txt2img"

    // 커스텀 타임아웃 세션
    private let session: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 300 // 요청 타임아웃 (초)
        configuration.timeoutIntervalForResource = 300 // 리소스 전체 수신 타임아웃

        return Session(configuration: configuration)
    }()

    func generateImage(prompt: String, negativePrompt: String) async throws -> UIImage? {
        let request = Txt2ImgRequest(prompt: prompt, negativePrompt: negativePrompt)

        let dataTask = session.request(
            baseURL,
            method: .post,
            parameters: request,
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .serializingDecodable(Txt2ImgImageOnlyResponse.self)

        let result = try await dataTask.value

        guard let base64 = result.images.first,
              let data = Data(base64Encoded: base64),
              let image = UIImage(data: data) else {
            print("이미지 디코딩 실패")
            return nil
        }

        return image
    }
}

*/
