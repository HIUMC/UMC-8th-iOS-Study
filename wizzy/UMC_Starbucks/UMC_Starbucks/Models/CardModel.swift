//
//  CardModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 6/20/25.
//

import Foundation
import SwiftData

@Model
class CardModel {
    var id: UUID
    var imageName: String       // 카드 이미지 이름 (예: "starbucks_card_A")
    var cardName: String        // 카드 이름 (예: "아무카드 A")
    var cardMoney: Int          // 카드 잔액 (예: 999)
    var cardNumber: String      // 카드 번호 전체 (16자리 문자열)
    var activationDate: Date    // 마지막 활성화 시간

    init(id: UUID = UUID(), imageName: String, cardName: String, cardMoney: Int, cardNumber: String, activationDate: Date) {
        self.id = id
        self.imageName = imageName
        self.cardName = cardName
        self.cardMoney = cardMoney
        self.cardNumber = cardNumber
        self.activationDate = activationDate
    }
}
