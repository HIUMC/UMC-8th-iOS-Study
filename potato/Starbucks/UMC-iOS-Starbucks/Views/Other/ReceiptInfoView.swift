//
//  ReceiptInfoView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/8/25.
//

import SwiftUI

struct ReceiptInfoView: View {
    let receipt: ReceiptsModel
    
    @State private var isPresenting = false
    @State private var selectedReceipt: ReceiptsModel? = nil
//    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
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
                    .onTapGesture {
//                        selectedReceipt = receipt
                        isPresenting.toggle()
                    }
                    .fullScreenCover(item: $selectedReceipt) { selectedReceipt in
                        ZStack {
                            if let data = selectedReceipt.image,
                               let image = UIImage(data: data) {
                                Image(uiImage: image)
                            } else {
                                Text("이미지가 없습니다")
                                    .font(.mainTextSemiBold16)
                                    .foregroundStyle(Color("black02"))
                            }
                            
                            Button(action: {
                                self.selectedReceipt = nil
                            }) {
                                Image(systemName: "xmark")
                            }
                        }
                    }
            }
            
            Divider()
                .foregroundStyle(Color("gray01"))
        }
        .padding(.horizontal, 20)
    }
}
