//
//  Card.swift
//  STARBUCKS
//
//  Created by 신민정 on 6/16/25.
//
import Foundation
import SwiftData

@Model
class CardModel {
    var id: UUID
    var name: String
    var balance: Int
    var cardNumber: String
    var imageData: Data

    init(id: UUID, name: String, balance: Int, cardNumber: String, imageData: Data) {
        self.id = id
        self.name = name
        self.balance = balance
        self.cardNumber = cardNumber
        self.imageData = imageData
    }
}



