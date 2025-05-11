//
//  OrderCoffeeModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/29/25.
//

import Foundation

struct OrderCoffeeModel: Identifiable {
    let id = UUID()
    var img: String
    var name: String
    var nameEng: String
}
