//
//  ReceiptModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/15/25.
//
//
//import SwiftData
//import Foundation
//
//@Model
//class ReceiptImage {
//    
//    var id: UUID
//    var data: Data
//   
//    @Relationship(.belongsTo, inverse: \.receiptImage)
//    var receipt: Receipt
//
//    init(
//        id: UUID = UUID(),
//        data: Data,
//        receipt: Receipt? = nil
//    ) {
//        self.id = id
//        self.data = data
//        self.receipt = receipt ?? Receipt() // 관계 연결!
//    }
//}
