//
//  ReceiptsImageView.swift
//  Starbucks
//
//  Created by 박정환 on 4/9/25.
//

import SwiftUI

struct ReceiptImageViewer: View {
    @Environment(\.dismiss) var dismiss
    let receipt: ReceiptsModel

    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()

            if let data = receipt.image?.data,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .overlay(alignment: .topTrailing) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .foregroundStyle(.black)
                                .frame(width: 18, height: 18)
                                .padding(30)
                        })
                    }
                
            } else {
                ZStack {
                    Text("이미지가 없습니다.")
                        .foregroundColor(.white)
                    HStack {
                        Spacer()
                        VStack {
                            Button(action: {
                                dismiss()
                            }, label: {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .foregroundStyle(.gray04)
                                    .frame(width: 18, height: 18)
                            })
                            Spacer()
                        }
                    }
                }
                .padding(20)
            }
        }
    }
}
