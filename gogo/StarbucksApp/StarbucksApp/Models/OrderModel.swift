//
//  OrderModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/29/25.
//

import Foundation

struct OrderModel : Identifiable {
    let id = UUID()
    let name: String
    let subTitle: String
    let imageName: String
    
}
