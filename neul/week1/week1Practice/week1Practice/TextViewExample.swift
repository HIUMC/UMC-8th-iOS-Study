//
//  TextViewExample.swift
//  week1Practice
//
//  Created by tokkislove on 3/20/25.
//

import SwiftUI

struct TextViewExample: View {
    var body: some View {
        Text("Hello, SwiftUI!\n 라라라랄 \n ㅎㅎ")
            .font(.title) // 글자 크기 설정
            .foregroundStyle(Color.pink) // 색깔
            .underline() // 밑줄
            .strikethrough(true, color: Color.cyan) // 중간 줄 그음
            .lineLimit(2) // 줄 개수 제한
            .kerning(3) // 글자 사이 간격! 근데 tracking이라는 애도 있음...
            .lineSpacing(20) // 줄 사이 간격
            .padding() // 패딩
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.yellow)
                    .stroke(Color.brown, style: .init(lineWidth:5))
                    .opacity(0.2)
            } // 이 위를 덮는듯...
            .dynamicTypeSize(.xxxLarge) // 텍스트 뷰의 크기 자체가 바뀜
        Image(systemName: "sun.min")
    }
}

#Preview {
    TextViewExample()
}
