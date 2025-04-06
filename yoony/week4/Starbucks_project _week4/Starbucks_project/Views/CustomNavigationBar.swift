//
//  CustomNavigationBar.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/3/25.
//

import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    let onBack: () -> Void
    
    
    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
            }
            Spacer()
            Text(title)
                .font(.headline)
            Spacer()
            Button(action: {}) { // 우측 버튼 (필요할 경우 추가)
                Image(systemName: "ellipsis")
                    .foregroundColor(.clear) // 우측 버튼이 없을 경우 빈 공간 유지
            }
        }
        .padding()
        .background(Color.white)
    }
}

