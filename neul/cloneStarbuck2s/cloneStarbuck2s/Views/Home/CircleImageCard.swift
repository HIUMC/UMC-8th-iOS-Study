//
//  CircleImageCard.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/3/25.
//
import SwiftUI

struct CircleImageCard: View {
    private var imageName: String
    private var title: String
    
    // 암묵적 init을 해주고 싶었지만, private 레벨이라 외부에서 멤버변수에 접근이 안돼서 어쩔 수 없이 명시적 init~~
    init(imageName: String, title: String) {
        self.imageName = imageName
        self.title = title
    }
    
    var body: some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .frame(width: 130, height: 130)
            Text(title)
                .font(.MainTextSemiBold14)
                .foregroundStyle(.black02)
        }
    }
}
