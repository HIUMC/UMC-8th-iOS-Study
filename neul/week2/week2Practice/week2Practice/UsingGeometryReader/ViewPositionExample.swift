//
//  ViewPositionExample.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

// geometryreader를 활용한 좌표값 가져오기
struct ViewPositionExample: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("뷰의 X좌표: \(geometry.frame(in: .global).origin.x)")
                Text("뷰의 Y좌표: \(geometry.frame(in: .global).origin.y)")
            }
            .frame(width: 200, height: 100)
            .background(Color.orange.opacity(0.5))
            // VStack의 자리를 옮김
            .position(x: geometry.size.width/2, y: geometry.size.height/2)
        }
        
    }
}

#Preview {
    ViewPositionExample()
}
