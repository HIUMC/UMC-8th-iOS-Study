//
//  RecieptModel.swift
//  Starbucks
//
//  Created by 박정환 on 4/8/25.
//

import Foundation
import SwiftData

@Model
class ReceiptsModel {
    @Attribute(.unique) var id: UUID // 고유 식별자 ( 데이터베이스의 기본키처럼 동작합니다 )
    
    var store: String            // 지점
    var totalAmount: Int         // 결제 금액
    var date: String             // 결제 시간
    var createdAt: Date          // 저장된 시점
    
    @Relationship var image: ReceiptsImage? //SwiftData 내 모델 간의 클래스 연결
    
    init(
        store: String,
        date: String,
        totalAmount: Int,
        createdAt: Date = Date(),
        image: ReceiptsImage? = nil
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
class ReceiptsImage {
    var data: Data

    @Relationship(inverse: \ReceiptsModel.image) var receipt: ReceiptsModel?

    init(data: Data, receipt: ReceiptsModel? = nil) {
        self.data = data
        self.receipt = receipt
    }
}



/*
@Model
class ReceiptsImageModel {
    @Attribute(.unique) var id: UUID
    
    @Attribute(.externalStorage) var photo: Data? // 영수증 사진
    
    @Relationship(.unique) var receipt: ReceiptsModel?

    init(id: UUID = UUID(), photo: Data) {
        self.id = id
        self.photo = photo
    }
}
*/
