//
//  TokenProviding.swift
//  7st_Practice
//
//  Created by 김영택 on 5/22/25.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
