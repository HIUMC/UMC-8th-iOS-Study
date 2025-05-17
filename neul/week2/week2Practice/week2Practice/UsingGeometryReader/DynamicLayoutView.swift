//
//  ViewPositionExample.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

//GeometryReader를 활용한 동적 레이아웃
struct DynamicLayoutView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("전체 화면 크기의 50% 박스")
                    .frame(width: geometry.size.width*0.5, height: geometry.size.height*0.3)
                    .background(.pink)
                    .border(.blue)
            }
            // 여기선 전체 화면 크기 적용(이걸 해줘야 박스가 화면 중앙에 감)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .border(.red)
        }
        
        
    }
}

#Preview {
    DynamicLayoutView()
}
