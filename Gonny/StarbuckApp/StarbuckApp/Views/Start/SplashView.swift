//
//  SplashView.swift
//  StarbuckApp
//
//  Created by 박병선 on 3/24/25.
//
import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            
            Color("green01")
                .edgesIgnoringSafeArea(.all) //뷰가 safe area 무시하고 화면 전체를 꽉 채우는 역할

        
            Image("starbuckLogo")
                .resizable() /*원래 SwiftUI에서 이미지는 원본 크기 그대로 표시되는데 이 확장자를 이용하면 조정가능! 애 안 쓰면은  frame(width: height:) 써도 말짱도루묵*/
                .scaledToFit() /* 가로 세로 비율을 유지라면서 프레임에 맞추는 방식으로 크기 조절 그니까 이미지가 찌그러지지 않도록 프레임 안에 최대한 꽉 차도록 만들어줌*/
                .frame(width: 168, height: 168) // 크기 조절
        }
    }
}

#Preview {
    SplashView()
}
