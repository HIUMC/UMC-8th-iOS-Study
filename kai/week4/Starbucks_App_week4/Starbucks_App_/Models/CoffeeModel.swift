//
//  americanoModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/3/25.
//

import Foundation

enum CoffeeType: String {
    case iced = "ICED"
    case hot = "HOT"
}

struct CoffeeModel: Hashable, Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let englishName: String
    let description: String
    let price: Int
    let availableTypes: [CoffeeType]
}
