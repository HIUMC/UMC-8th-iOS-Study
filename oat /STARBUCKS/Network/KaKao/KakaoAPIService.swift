//
//  KakaoAPIService.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/21/25.
//
import Foundation
import Alamofire

class KakaoAPIService {
    static let shared = KakaoAPIService()
    
    func requestToken(code: String) async throws -> KakaoTokenResponse {
        let url = "https://kauth.kakao.com/oauth/token"
        let parameters: [String: String] = [
            "grant_type": "authorization_code",
            "client_id": KakaoKeys.restAPIKey,
            "redirect_uri": KakaoKeys.redirectURI,
            "code":code
        ]

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .post,
                       parameters: parameters,
                       encoder: URLEncodedFormParameterEncoder.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    if let jsonObject = try? JSONSerialization.jsonObject(with: data),
                       let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                       let jsonString = String(data: jsonData, encoding: .utf8) {
                        print("✅ Kakao Token 응답:\n\(jsonString)")
                    }

                    do {
                        let decoder = JSONDecoder()
//                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let token = try decoder.decode(KakaoTokenResponse.self, from: data)
                        continuation.resume(returning: token)
                    } catch {
                        continuation.resume(throwing: error)
                    }

                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    
}
