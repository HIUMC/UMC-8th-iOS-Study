//
//  OrderCoffeeModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/2/25.
//

import Foundation
import SwiftUI

struct OrderCoffeeModel: Identifiable {
    var id = UUID()
    let title: String
    let engTitle: String
    let image: String
}
