//
//  StarbucksCardModel.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 6/18/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class StarbucksCardModel {
    // 카드이름, 잔액, 카드번호
    @Attribute(.unique) var cardName: String
    var balance: Int
    @Attribute(.unique) var cardNumber: Int
    @Attribute(.externalStorage) var cardPhoto: Data?
    
    init(cardName: String, cardNumber: Int, cardPhoto: Data? = nil)
    {
        self.cardName = cardName
        self.cardNumber = cardNumber
        self.balance = Int.random(in: 0...100_000)
        
        if let inputPhoto = cardPhoto {
            self.cardPhoto = inputPhoto
        } else if let defaultImage = UIImage(named: "starbucksCard") {
            self.cardPhoto = defaultImage.pngData()
        } else {
            self.cardPhoto = nil
        }
    }
}

struct ImageItem: Identifiable {
    let id = UUID()
    let image: UIImage
}
