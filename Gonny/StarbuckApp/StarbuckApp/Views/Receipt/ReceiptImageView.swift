//
//  ReceiptImageView.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/12/25.
//

import SwiftUI

struct ReceiptImage: View {
    //let image = UIimage(data:data)
    let image: UIImage
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // 반투명한 배경
             Color.black.opacity(0.7).ignoresSafeArea()
//              Color.red.ignoresSafeArea()
                
            
            VStack {
                Spacer()
                Image(uiImage: image)
                
                Spacer()
            }
            
            // 오른쪽 상단 X 버튼
            Button {
                dismiss()
            } label: {
                Image("xx")
                    
            }
        }
    }
}
