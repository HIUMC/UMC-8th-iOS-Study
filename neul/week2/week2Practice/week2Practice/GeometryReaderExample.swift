//
//  GeometryReaderExample.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

struct GeometryReaderExample: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("뷰 너비: \(geometry.size.width)")
                Text("뷰 높이: \(geometry.size.height)")
            }
            //동적 크기 설정
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.blue.opacity(0.3))
        }
        
        
    }
}

#Preview {
    GeometryReaderExample()
}
