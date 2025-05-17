//
//  CustomNavigationBar.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/3/25.
//

import SwiftUI

struct CustomNavigationBar: View {
    var title: String
    var onBack: (() -> Void)?
    
    var body: some View {
        HStack {
            Button(action: {
                onBack?()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }
            
            Spacer()
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Spacer()
            
            // 오른쪽 여백을 맞추기 위한 투명 버튼
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
        }
        .padding()
    }
}


#Preview {
    CustomNavigationBar(title: "생성하기")
}
