//
//  ColorNaivgationView.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

struct ColorNaivgationView: View {
    @Bindable var rainbowViewModel: RainbowViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 70) {
            if let selectedRainbowModel = rainbowViewModel.selectedRainbowModel {
                Text("현재 선택된 색상\n\(selectedRainbowModel.returnColorName())")
                    .font(.title)
                    .foregroundStyle(Color.black)
                
                Button(action: {
                    rainbowViewModel.appleLogoColor = selectedRainbowModel.returnColor()
                    dismiss()
                }, label: {
                    Text("사과 색 바꾸기")
                        .padding(.vertical, 43)
                        .padding(.horizontal, 36)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.clear)
                                .stroke(Color.blue, style: .init(lineWidth: 1))
                        })
                })
            }
        }
        .navigationTitle("색 네비")
    }
}
