//
//  RainbowView.swift
//  week3Lab
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct RainbowView: View {
    var viewModel: RainbowViewModel = .init()
    @State private var navOrNot: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                colorCardGroup
                Spacer()
                bottomApple
            }
            .safeAreaPadding(EdgeInsets(top: 47, leading: 15, bottom: 44, trailing: 15))
            .navigationDestination(isPresented: $navOrNot) {
                ColorNavigationView(viewModel: viewModel)
            }
        }
        
    }
    
    private var colorCardGroup: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 40), count: 3), spacing: 26, content: {
            ForEach(RainbowModel.allCases, id: \.self, content: { rainbow in
                makeColorCard(rainbow)
                    .onTapGesture {
                        viewModel.selectedRainbowModel = rainbow
                        // 와.. 이거 고능
                        self.navOrNot.toggle()
                    }
            })
        })
        .padding(.horizontal, 38.5)
    }
    
    private var bottomApple: some View {
        VStack(spacing: 70) {
            Image(.apple)
                .renderingMode(.template)
                .fixedSize()
                .foregroundStyle(viewModel.appleColor ?? Color.black)
            Text(selectedColorName())
                .font(.title)
                .foregroundStyle(.black)
                
        }
        
    }
    
    
    
    //하위뷰~ 만들기~~
    private func makeColorCard(_ model: RainbowModel) -> some View {
        VStack(spacing: 6) {
            Rectangle()
                .fill(model.returnColor())
            Text(model.returnColorName())
                .foregroundStyle(.black)
                .font(.title3)
        }
        .frame(maxWidth: .infinity, minHeight: 110)
    }
    
    
    private func selectedColorName() -> String {
        if let name = viewModel.selectedRainbowModel {
            return name.returnColorName()
        } else {
            return "아무것도 없음"
        }
    }
}

#Preview {
    RainbowView()
}
