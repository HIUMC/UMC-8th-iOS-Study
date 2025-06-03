//
//  TokenProviding.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/22/25.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
