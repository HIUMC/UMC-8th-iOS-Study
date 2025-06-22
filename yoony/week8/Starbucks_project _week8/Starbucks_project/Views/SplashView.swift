//
//  SplashView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/20/25.
//


import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(.green01) // 배경색 설정
                .ignoresSafeArea() // Safe Area 무시하여 전체 배경 적용

            Image(.starbuckslogo) // Assets에 있는 스타벅스 로고 이미지
                .resizable()
                .scaledToFit()
                .frame(width: 168, height: 168) // 이미지 크기 조정
        }
    }
}


#Preview {
    SplashView()
}
