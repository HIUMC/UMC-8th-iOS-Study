//
//  ReceiptInfo.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/8/25.
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
                        .font(.MainTextSemiBold18)
                        .foregroundStyle(.black)
                    Text(receipt.date)
                        .font(.MainTextMedium16)
                        .foregroundStyle(.gray03)
                    Text("\(receipt.totalAmount)원")
                        .font(.MainTextSemiBold18)
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
