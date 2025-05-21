//
//  TokenProviding.swift
//  week7Project
//
//  Created by nau on 5/20/25.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
