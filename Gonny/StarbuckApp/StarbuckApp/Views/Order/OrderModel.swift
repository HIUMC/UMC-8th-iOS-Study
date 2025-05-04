//
//  OrderModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/29/25.
//

import Foundation


struct OrderCoffeeItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
}
