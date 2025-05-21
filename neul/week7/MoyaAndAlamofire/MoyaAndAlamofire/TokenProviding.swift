//
//  TokenProviding.swift
//  MoyaAndAlamofire
//
//  Created by tokkislove on 5/20/25.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void) // 비동기 방식으로 토큰을 갱신하기 위함
}
