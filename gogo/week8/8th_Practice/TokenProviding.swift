//
//  TokenProviding.swift
//  MoyaTest
//


import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
}
