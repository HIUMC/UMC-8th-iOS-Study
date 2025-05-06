//
//  ReceiptInfo.swift
//  Starbucks
//
//  Created by 박정환 on 5/6/25.
//

import SwiftUI

struct ReceiptInfo: View {
    var receipt: ReceiptModel
    var action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 9) {
                    Text(receipt.store)
                        .font(.mainTextSemiBold18)
                        .foregroundStyle(.black)
                    Text(receipt.date)
                        .font(.mainTextMedium16)
                        .foregroundStyle(.gray03)
                    Text("\(receipt.totalAmount)원")
                        .font(.mainTextSemiBold18)
                        .foregroundStyle(.brown02)
                }
                .padding(.bottom, 14)
                
                Spacer()
                
                Button(action: {
                    action()
                }, label: {
                    Image("showReceipt")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 16, height: 20)
                })
                
            }
            
            Divider()
        }
        .padding(.horizontal, 19)
        
    }
    
}
