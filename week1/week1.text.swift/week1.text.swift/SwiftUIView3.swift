//
//  SwiftUIView3.swift
//  week1.text.swift
//
//  Created by 이서현 on 3/22/25.
//

import SwiftUI

struct SwiftUIView3: View {
    var body: some View {
        Button(action: {
            print("Button Clicked")
        }) {
            Text("Tap")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        
        Button(action: {
            print("레이블 클릭")
        }, label: {
            Label(title: {
                Text("레이블 내부 텍스트")
            }, icon: {
                Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                    .imageScale(.large)
            })
            .labelStyle(.titleAndIcon)
        })
    }
}

#Preview {
    SwiftUIView3()
}
