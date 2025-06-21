//
//  CardModel.swift
//  Starbucks
//
//  Created by 박정환 on 6/19/25.
//

import SwiftData
import Foundation

@Model
class CardModel {
    var id: UUID
    var name: String
    var balance: Int
    var cardNumber: String  // 12자리 전체 저장

    init(name: String, balance: Int, cardNumber: String) {
        self.id = UUID()
        self.name = name
        self.balance = balance
        self.cardNumber = cardNumber
    }

    // 마스킹된 카드번호 표시용
    var maskedCardNumber: String {
        let last4 = cardNumber.suffix(4)
        return "****-****-" + last4
    }
}
