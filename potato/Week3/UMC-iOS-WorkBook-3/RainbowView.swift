//
//  RainbowView.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

struct RainbowView: View {
    // 네비게이션 할지말지 결정하는 변수
    @State private var navigationTrue: Bool = false
    var rainbowViewModel: RainbowViewModel = .init()
    
    var body: some View {
        NavigationStack {
            VStack {
                colorCards
                
                Spacer()
                
                logo
            }
            .safeAreaPadding(EdgeInsets(top: 47, leading: 15, bottom: 43, trailing: 15))
            .navigationDestination(isPresented: $navigationTrue, destination: {
                ColorNaivgationView(rainbowViewModel: rainbowViewModel)
            })
        }
    }
    
    // 무지개 색상 카드 뷰(하나)
    private func makeColorCard(_ model: RainbowModel) -> some View{
        VStack(spacing: 6) {
            Rectangle()
                .fill(model.returnColor())
            
            Text(model.returnColorName())
                .foregroundStyle(Color.black)
                .font(.title)
        }
        .frame(maxWidth: .infinity, minHeight: 110)
    }
    
    // 무지개 색상 카드 뷰(전체)
    private var colorCards: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 40), count: 3), spacing: 26, content: {
            ForEach(RainbowModel.allCases, id: \.self, content: { rainbow in
                makeColorCard(rainbow)
                    .onTapGesture {
                        rainbowViewModel.selectedRainbowModel = rainbow
                        self.navigationTrue.toggle()
                    }
            })
        })
    }
    
    // 애플 로고와 색상 텍스트 뷰
    private var logo: some View {
        VStack(spacing: 70) {
            Image(.appleLogo)
                .renderingMode(.template)
                .fixedSize()
                .foregroundStyle(rainbowViewModel.appleLogoColor ?? Color.black)
            
            Text(selectedColorName())
                .font(.title)
                .foregroundStyle(Color.black)
        }
    }
    
    // 선택한 색상 이름 반환하는 함수
    private func selectedColorName() -> String {
        if let name = rainbowViewModel.selectedRainbowModel {
            return name.returnColorName()
        } else {
            return "아무것도 없음"
        }
    }
}

#Preview {
    RainbowView()
}
