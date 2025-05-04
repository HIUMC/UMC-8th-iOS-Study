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
