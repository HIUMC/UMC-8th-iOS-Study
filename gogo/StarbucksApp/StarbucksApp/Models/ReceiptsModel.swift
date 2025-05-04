////
////  ReceiptModel.swift
////  StarbucksApp
////
////  Created by 고석현 on 4/15/25.
////
////


//import Foundation
//import SwiftData
//
//@Model
//class ReceiptsModel: Identifiable {
//    @Attribute(.unique) var id: UUID
//    var orderer: String
//    var store: String
//    var totalAmount: Int
//    var orderNumber: String
//    var createdAt: Date
//    @Relationship(.unique) var image: ReceiptsImageModel?
//
//    init(orderer: String, store: String, totalAmount: Int, orderNumber: String, createdAt: Date = Date()) {
//        self.id = UUID()
//        self.orderer = orderer
//        self.store = store
//        self.totalAmount = totalAmount
//        self.orderNumber = orderNumber
//        self.createdAt = createdAt
//    }
//}
//
//@Model
//class ReceiptsImageModel {
//    @Attribute(.unique) var id: UUID
//    @Attribute(.externalStorage) var photo: Data?
//    @Relationship(.unique) var receipt: ReceiptsModel?
//
//    init(photo: Data) {
//        self.id = UUID()
//        self.photo = photo
//    }
//}

//
//  ReceiptModel.swift
//  Starbucks
//
//  Created by nau on 4/8/25.
//

import Foundation
import SwiftData
import UIKit

@Model
class ReceiptModel: Identifiable {
    @Attribute(.unique) var id: UUID // 고유 식별자
    
    //이미지 1:1로 처음에 데이터형식으로 저장
    @Relationship(.unique) var receiptImageData: Data?
    
    var store: String            // 장소
    var totalAmount: Int         // 결제 금액
    var date: String             // 날짜~
    var createdAt: Date          // 저장된 시점
    
    //데이터 -> UIImage로 리턴해줌
    var receiptImage : UIImage? {
        get {
            guard let data = receiptImageData else { return nil }
            return UIImage(data: data)
        }
        set {
            guard let newImage = newValue, let imageData = newImage.pngData() else { return }
            receiptImageData = imageData
        }
    }
    
    
    
    init(
        store: String,
        totalAmount: Int,
        date: String,
        receiptImage: UIImage,
        createdAt: Date = Date()
    ) {
        self.id = UUID()
        self.store = store
        self.totalAmount = totalAmount
        self.date = date
        self.createdAt = createdAt
        self.receiptImage = receiptImage
    }
}
