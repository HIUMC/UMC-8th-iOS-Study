//
//  TokenProviding.swift
//  7th_Practice2
//
//  Created by 박병선 on 5/20/25.
//
import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
