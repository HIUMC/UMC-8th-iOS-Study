//
//  ReceiptModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/8/25.
//
import Foundation
import SwiftData

@Model
class ReceiptModel: Hashable {
    @Attribute(.unique) var id: UUID
    
    var store: String
    var date: String
    var totalAmount: Int
    var createdAt: Date
    
    @Relationship var image: ReceiptImage?
    
    init(
        store: String,
        date: String,
        totalAmount: Int,
        createdAt: Date = .now,
        image: ReceiptImage? = nil
    ) {
        self.id = UUID()
        self.store = store
        self.date = date
        self.totalAmount = totalAmount
        self.createdAt = createdAt
        self.image = image
    }
}


@Model
class ReceiptImage {
    var data: Data

    @Relationship(inverse: \ReceiptModel.image) var receipt: ReceiptModel?

    init(data: Data, receipt: ReceiptModel? = nil) {
        self.data = data
        self.receipt = receipt
    }
}
