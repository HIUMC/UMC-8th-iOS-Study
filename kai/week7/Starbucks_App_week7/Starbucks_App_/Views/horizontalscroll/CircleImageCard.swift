//
//  CircleImageCard.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/3/25.
//


import SwiftUI

struct CircleImageCard: View {
    var onTap: (() -> Void)? = nil  // 탭 액션을 외부에서 지정 가능
    private var imageName: String
    private var title: String
    private var imageSize: CGFloat  // 이미지 크기 지정용

    
    // 초기화
    init(imageName: String, title: String, imageSize: CGFloat = 130) {
        self.imageName = imageName
        self.title = title
        self.imageSize = imageSize
    }

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: imageSize, height: imageSize)
            
            Spacer().frame(height: 10)
            
            Text(title)
                .font(.PretendardMedium16)
                .foregroundStyle(.black)
        }
        .onTapGesture {
            onTap?()  // 외부에서 정의한 액션 실행
        }
    }
}
