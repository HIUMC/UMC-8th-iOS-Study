//
//  PayModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 6/17/25.
//
import SwiftUI
import SwiftData

@Model
class PayModel {
    var id: UUID
    var name: String
    var balance: Int
    var cardNumber: String
     var receiptImageData: Data?
    
    //데이터 -> UIImage로 리턴해줌
    var image : UIImage? {
        get {
            guard let data = receiptImageData else { return nil }
            return UIImage(data: data)
        }
        set {
            receiptImageData = newValue?.pngData()
        }
    }
    
    init(name: String, balance: Int, cardNumber: String, image: UIImage?) {
        self.id = UUID()
        self.name = name
        self.balance = balance
        self.cardNumber = cardNumber
        self.receiptImageData = image?.pngData()
    }
    var maskedCardNumber: String {
        let last4 = cardNumber.suffix(4)
        return "**** **** **** \(last4)"
    }
}
/*
var images: [PayModel] = (1...8).map {
    PayModel(image: "Profile \($0)", name: "카드 \($0)", balance: 10000 * $0, cardNumber: "1234567890\($0)\($0)")
}
*/

