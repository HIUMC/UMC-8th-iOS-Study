//
//  APIManager.swift
//  cloneStarbucks
//
//  Created by tokkislove on 5/20/25.
// Moya provider를 생성하고 관리

import Foundation
import Moya
import Alamofire

class APIManager: @unchecked Sendable {
    static let shared = APIManager()
    
    //private let tokenProvider: TokenProviding
    private let accessTokenRefresher: AccessTokenRefresher
    private let session: Session
    private let loggerPlugin: PluginType
    
    private init() {
        //tokenProvider = TokenProvider()
        //accessTokenRefresher = AccessTokenRefresher(tokenProviding: tokenProvider)
        accessTokenRefresher = AccessTokenRefresher()
        session = Session(interceptor: accessTokenRefresher)
        
        loggerPlugin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
    }
    
    /// 실제 API 요청용 MoyaProvider
    public func createProvider<T: TargetType>(for targetType: T.Type) -> MoyaProvider<T> {
        return MoyaProvider<T>(
            session: session,
            plugins: [loggerPlugin]
        )
    }
    
    /// 테스트용 MoyaProvider
    public func testProvider<T: TargetType>(for targetType: T.Type) -> MoyaProvider<T> {
        return MoyaProvider<T>(
            stubClosure: MoyaProvider.immediatelyStub,
            plugins: [loggerPlugin]
        )
    }
}


extension MoyaProvider {
    func requestAsync(_ target: Target) async throws -> Response {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
