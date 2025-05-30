//
//  TokenProviding.swift
//  week7_practice
//
//  Created by 김지우 on 5/22/25.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
