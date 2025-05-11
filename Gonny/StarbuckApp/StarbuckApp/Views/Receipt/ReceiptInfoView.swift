//
//  ReceiptInfo.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/12/25.
//
import Foundation
import SwiftUI

struct ReceiptInfoView: View {
    let receipt: ReceiptsModel

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("주문자: \(receipt.orderer)")
            Text("장소: \(receipt.store)")
//            Text("마신 음료: \(receipt.menuItems.joined(separator: ", "))")
            Text("결제 금액: \(receipt.totalAmount)원")
            Text("주문번호: \(receipt.orderNumber)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
