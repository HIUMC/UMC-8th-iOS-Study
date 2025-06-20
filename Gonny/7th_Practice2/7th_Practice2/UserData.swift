//
//  UserData.swift
//  7th_Practice2
//
//  Created by 박병선 on 5/20/25.
//
import Foundation

struct UserData: Codable {
    let name: String
    let age: Int
    let address: String
    let height: Double
}

struct UserPatchRequest: Codable {
    let name: String?
    let age: Int?
    let address: String?
    let height: Double?
}
