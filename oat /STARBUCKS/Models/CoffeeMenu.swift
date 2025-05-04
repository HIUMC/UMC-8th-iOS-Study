//
//  orderModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/28/25.
//

import Foundation

struct CoffeeMenu: Identifiable {
    var id = UUID()
    var imageName: String
    var koreanName: String
    var englishName: String
}
