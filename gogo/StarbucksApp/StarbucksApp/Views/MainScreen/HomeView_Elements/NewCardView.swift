//
//  WhatsNewCardView.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/7/25.
//

//


import SwiftUI


struct NewCardView: View {
    private var imageName: String
    private var title: String
    private var text: String
    
    init(imageName: String, title: String, text: String) {
        self.imageName = imageName
        self.title = title
        self.text = text
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image(imageName)
                .frame(width: 242, height: 160)
            Text(title)
                .font(.PretendardSemiBold18)
                .foregroundStyle(.black02)
                
            Text(text)
                .font(.PretendardSemiBold13)
                .foregroundStyle(.gray03)
                .lineLimit(nil)  // 줄바꿈 허용
        }
        .frame(maxWidth: 240,maxHeight: .infinity)
    }
}
