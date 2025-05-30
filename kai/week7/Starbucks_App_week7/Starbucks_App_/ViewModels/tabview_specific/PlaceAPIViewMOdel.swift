//
//  PlaceAPIViewMOdel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/29/25.
//

import Foundation
import Moya

extension MoyaProvider where Target == PlaceAPI {
    func requestAsync(_ target: PlaceAPI) async throws -> PlaceResponse {
        try await withCheckedThrowingContinuation { continuation in
            self.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode(PlaceResponse.self, from: response.data)
                        continuation.resume(returning: decoded)
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

