//
//  ReceiptModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/8/25.
//
import SwiftData
import Foundation

@Model
class Receipt {
    var storeName: String
    var date: Date
    var amount: Int
    
    init(storeName: String, date: Date, amount: Int) {
            self.storeName = storeName
            self.date = date
            self.amount = amount
        }
}

