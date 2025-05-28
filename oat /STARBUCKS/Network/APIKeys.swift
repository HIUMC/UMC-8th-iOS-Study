//
//  APIKeys.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/26/25.
//


import Foundation

enum APIKeys {
    static var googlePlaces: String {
        return Bundle.main.infoDictionary?["GOOGLE_API_KEY"] as? String ?? ""
    }
}

