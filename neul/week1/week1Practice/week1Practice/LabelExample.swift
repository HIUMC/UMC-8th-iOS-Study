//
//  LabelExample.swift
//  week1Practice
//
//  Created by tokkislove on 3/22/25.
//

import SwiftUI

struct LabelExample: View {
    var body: some View {
        //label이란 아이콘과 텍스트를 함께 표시
        Label("favorites", systemImage: "star.fill")
        Button(action: {
            print("레이블 클릭됨")
        }) {
            Label(title: {
                Text("i am label")
            }, icon: {
                Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                    .imageScale(.large)
            })
            .labelStyle(.titleAndIcon)
        }
    }
}

#Preview {
    LabelExample()
}
