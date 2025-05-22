//
//  KakaoInterceptor.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/20/25.
//
// Alamofire 의 Interceptor 사용하여 헤더를 카카오 인증 키 헤더에 넣도록 구성
import Foundation
import Alamofire


class KakaoInterceptor: RequestInterceptor, @unchecked Sendable {
    private let kakaoAPIKey: String

    init() {
        self.kakaoAPIKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_REST_API_KEY") as? String ?? ""
        print("🔐 불러온 REST API 키:", kakaoAPIKey)
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        request.headers.add(.authorization("KakaoAK \(kakaoAPIKey)"))
        print(request.headers)

        completion(.success(request))
    }
}
