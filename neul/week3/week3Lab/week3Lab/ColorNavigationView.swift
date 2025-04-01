//
//  ColorNavigationView.swift
//  week3Lab
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI
import Observation

struct ColorNavigationView: View {
    @Bindable var viewModel: RainbowViewModel
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            if let selectedRainbowModel = viewModel.selectedRainbowModel {
                Text("현재 선택된 색상 \n\(selectedRainbowModel.returnColorName())")
                    .font(.title)
                    .foregroundStyle(Color.black)
                     
                Button(action: {
                    viewModel.appleColor = selectedRainbowModel.returnColor()
                    dismiss()
                }, label: {
                    Text("사과 색 바꾸기")
                        .padding(.vertical, 43)
                        .padding(.horizontal, 36)
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.clear)
                                .stroke(Color.black, style: .init(lineWidth: 1))
                        })
                })
            }
        }
        .navigationTitle("색 네비? (뭐?)")
    }
}

