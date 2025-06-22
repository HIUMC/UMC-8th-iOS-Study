//
//  AIImageService.swift
//  Starbucks_project
//
//  Created by Yoonseo on 6/19/25.
//

import Foundation
import Combine
import Moya
import CombineMoya


final class AIImageService {
    private let provider = MoyaProvider<AIImageTarget>()
    
    func generateImage(prompt: String, negativePrompt: String) -> AnyPublisher<[String], Error> {
        let request = Txt2ImgRequest(prompt: prompt, negativePrompt: negativePrompt)
        
        return provider.requestPublisher(.generateImage(request: request))
            .tryMap { response -> [String] in
                let result = try JSONDecoder().decode(Txt2ImgImageOnlyResponse.self, from: response.data)
                return result.images
            }
            .eraseToAnyPublisher()
    }
    
    func fetchProgress() -> AnyPublisher<Double, Error> {
        return provider.requestPublisher(.checkProgress)
            .tryMap { response -> Double in
                let json = try JSONSerialization.jsonObject(with: response.data) as? [String: Any]
                return json?["progress"] as? Double ?? 0
            }
            .eraseToAnyPublisher()
    }
}
