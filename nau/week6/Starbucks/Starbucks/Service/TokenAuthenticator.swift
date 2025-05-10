//
//  AuthorizationInterceptor.swift
//  Starbucks
//
//  Created by nau on 5/8/25.
//

import Foundation
import Alamofire

final class TokenAuthenticator: Authenticator {
    typealias credential = Credential

    // 1. 요청에 토큰 적용
    func apply(_ credential: credential, to urlRequest: inout URLRequest) {
        urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
    }

    // 2. 인증 실패 여부 판단 (401이면 실패로 판단)
    func didRequest(_ urlRequest: URLRequest,
                    with response: HTTPURLResponse,
                    failDueToAuthenticationError error: Error) -> Bool {
        return response.statusCode == 401
    }

    // 3. 요청이 이 자격 증명으로 인증되었는지 확인
    func isRequest(_ urlRequest: URLRequest,
                   authenticatedWith credential: credential) -> Bool {
        let bearerToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
        return urlRequest.headers["Authorization"] == bearerToken
    }

    // 4. 토큰 갱신 로직 (네트워크 호출 또는 로컬 재발급 등)
    func refresh(_ credential: credential,
                 for session: Session,
                 completion: @escaping (Result<Credential, Error>) -> Void) {

        // 갱신 API 요청
        print("토큰 갱신 중...")
        let newCredential = Credential(
            accessToken: "new_access_token",
            expiration: Date().addingTimeInterval(3600)
        )
        completion(.success(newCredential))
    }
}
