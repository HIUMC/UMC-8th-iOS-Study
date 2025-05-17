//
//  ReceiptsModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/8/25.
//

import Foundation
import SwiftData

@Model
class ReceiptsModel {
    @Attribute(.unique) var id: UUID
    
    var store: String
    var totalAmount: Int
    var date: String
    var image: Data?
    var createdAt: Date

    init(store: String, totalAmount: Int, date: String, createdAt: Date = Date()) {
        self.id = UUID()
        self.store = store
        self.totalAmount = totalAmount
        self.date = date
        self.createdAt = createdAt
    }
}
