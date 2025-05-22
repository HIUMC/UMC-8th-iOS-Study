//
//  TokenProviding.swift
//  APIManagerTest
//
//  Created by 이서현 on 5/19/25.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
