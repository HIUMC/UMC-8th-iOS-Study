//
//  SwiftUIView2.swift
//  week1.text.swift
//
//  Created by 이서현 on 3/22/25.
//

import SwiftUI

struct SwiftUIView2: View {
    var body: some View {
        Image(systemName: "eraser.fill")
            .resizable()
            .frame(width: 300, height: 300)
            .aspectRatio(contentMode: .fit) //aspectRatio면.. 가로?
            .background() {
                Circle()
                    .fill(Color.green)
                    .frame(width: 250, height: 250)
                    .border(Color.black) //도형의 겉네모 테두리
            }
            .border(Color.red) //이미지 겉네모 테두리
            .clipShape(RoundedRectangle(cornerRadius: 100))
            .foregroundColor(Color.red) //둥근네모 빨간색인데 왜 지우개 색이 빨갛지?
        
        
        
    }
}

#Preview {
    SwiftUIView2()
}
