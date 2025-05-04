//
//  ReceiptsModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/6/25.
//
import Foundation
import SwiftData

@Model
class ReceiptsModel: Identifiable {
    @Attribute(.unique) var id: UUID
    var orderer: String
    var store: String
    var totalAmount: Int
    var orderNumber: String
    var createdAt: Date
    @Relationship(.unique) var image: ReceiptsImageModel?

    init(orderer: String, store: String, totalAmount: Int, orderNumber: String, createdAt: Date = Date()) {
        self.id = UUID()
        self.orderer = orderer
        self.store = store
        self.totalAmount = totalAmount
        self.orderNumber = orderNumber
        self.createdAt = createdAt
    }
}

@Model
class ReceiptsImageModel {
    @Attribute(.unique) var id: UUID
    @Attribute(.externalStorage) var photo: Data?
    @Relationship(.unique) var receipt: ReceiptsModel?

    init(photo: Data) {
        self.id = UUID()
        self.photo = photo
    }
}
