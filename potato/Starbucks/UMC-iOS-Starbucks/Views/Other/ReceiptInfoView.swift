//
//  ReceiptInfoView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/8/25.
//

import SwiftUI

struct ReceiptInfoView: View {
    let receipt: ReceiptsModel

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(receipt.store)
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(Color("black00"))
                Text(receipt.date)
                    .font(.mainTextMedium16)
                    .foregroundStyle(Color("gray03"))
                Text("\(receipt.totalAmount)원")
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(Color("brown02"))
            }
            
            Spacer()
            
            Image(.dollar)
            
            Divider()
                .foregroundStyle(Color("gray01"))
        }
        .padding(.horizontal, 20)
    }
}
