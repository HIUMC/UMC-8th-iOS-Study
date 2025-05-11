//
//  OtherViewButton.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/31/25.
//
import SwiftUI

struct OtherViewButton: View {
    private var image: String
    private var title: String
    
    init(image: String, title: String) {
        self.image = image
        self.title = title
    }
    
    
    var body: some View {
        Button(action: {
            print("otherViewButton: \(title) 버튼 눌림")
        }, label: {
            HStack(spacing: 5) {
                Image(image)
                    .resizable()
                    .frame(width: 32, height: 32)
                Text(title)
                    .foregroundStyle(Color.black02)
                    .font(.MainTextSemiBold16)
            }
            
        })
    }
}

#Preview {
    OtherViewButton(image: "card", title: "스타벅스 카드 등록")
}
