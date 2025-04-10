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
                        isPresenting.toggle()
                    }
                    .fullScreenCover(isPresented: $isPresenting) {
                        ZStack {
                            Color.black.opacity(0.6)
                                .ignoresSafeArea()
                            
                            if let data = receipt.image,
                               let image = UIImage(data: data) {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .overlay(alignment: .topTrailing) {
                                        Button(action: {
                                            isPresenting.toggle()
                                        }) {
                                            Image(systemName: "xmark")
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                                .foregroundStyle(Color("gray04"))
                                                .padding(16)
                                        }
                                    }
                            } else {
                                Text("이미지가 없습니다")
                                    .font(.mainTextSemiBold16)
                                    .foregroundStyle(Color("black02"))
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        isPresenting.toggle()
                                    }) {
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                    }
                                }
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
