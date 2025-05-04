//
//  ReciptsModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/13/25.
//

import Foundation
import SwiftData

@Model
class ReceiptsModel {
    
    var orderer: String
    var store: String
    var menuItems: String
    var totalAmount: Int
    var orderNumber: String
    var createdAt: Date
    
    init(
            orderer: String,
            store: String,
            menuItems: String,
            totalAmount: Int,
            orderNumber: String,
            createdAt: Date = Date()
        ) {
            self.orderer = orderer
            self.store = store
            self.menuItems = menuItems
            self.totalAmount = totalAmount
            self.orderNumber = orderNumber
            self.createdAt = createdAt
        }
}
