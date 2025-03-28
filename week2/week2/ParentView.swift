//
//  TopView.swift
//  week2
//
//  Created by 이가원 on 3/26/25.
//

import SwiftUI
struct GeometryReaderExample: View {
    var body: some View{
        GeometryReader{ geometry in
            VStack{
                Text("전체 화면의 50% 크기 박스")
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height * 0.3)
                    .background(Color.green)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.yellow)
            .border(Color.black)
        }
    }
    
}


#Preview {
    GeometryReaderExample()
}
