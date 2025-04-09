//
//  CoffeeModel.swift
//  Starbucks
//
//  Created by 이가원 on 4/5/25.
//

import Foundation

enum CoffeeOption {
    case hotIced
    case hotOnly
    case icedOnly
}

struct Coffee: Identifiable {
    let id = UUID()
    let name: String
    let engName: String
    let imageName: String
    let text: String
    let price: Int
    let option: CoffeeOption
}
