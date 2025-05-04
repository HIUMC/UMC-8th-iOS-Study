//
//  OrderCoffeeModel.swift
//  Starbucks
//
//  Created by 박정환 on 5/2/25.
//

import Foundation

struct OrderCoffeeModel: Identifiable {
    let id = UUID()
    var img: String
    var name: String
    var nameEng: String
}
