//  PayViewModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 6/17/25.



import SwiftData
import Foundation
import UIKit

class PayViewModel: ObservableObject {
    func addDummyCards(context: ModelContext) {
        // 이미지 파일을 불러와 UIImage로 변환
        func uiImage(forImageNamed name: String) -> UIImage? {
            return UIImage(named: name)
        }

        let cardA = PayModel(
            name: "아무카드 A",
            balance: 999,
            cardNumber: "123456781234",
            image: uiImage(forImageNamed: "Profile 1")
        )

        let cardB = PayModel(
            name: "아무카드 B",
            balance: 1200,
            cardNumber: "567856785678",
            image: uiImage(forImageNamed: "Profile 2")
        )

        let cardC = PayModel(
            name: "아무카드 C",
            balance: 20000,
            cardNumber: "111122223333",
            image: uiImage(forImageNamed: "Profile 3")
        )

        // SwiftData에 insert
        context.insert(cardA)
        context.insert(cardB)
        context.insert(cardC)
    }
}
