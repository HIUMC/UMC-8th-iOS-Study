//
//  ISBNScannerView.swift
//  Practice6
//
//  Created by 신민정 on 5/13/25.
//

import SwiftUI

struct ISBNScanncerView: View {
    
    @Bindable var viewModel: ISBNScannerViewModel = .init()
    
    let title: String = "바코드를 스캔해주세요"
    let subTitle: String = "ISBN 바코드 스캔을 통해 \n책의 정보를 빠르고 정확하게 가져올 수 있어요!"
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            BarcodeScannerView { isbn in
                Task {
                    await viewModel.searchBook(isbn: isbn)
                }
            }
        }
        backgroundView()
    }
    
    @ViewBuilder
    private func backgroundView() -> some View {
        Image(.scanGuide)
            .resizable()
            .overlay(content: {
                guidlineView()
            })
            .ignoresSafeArea(.all)
    }
    
    @ViewBuilder
    private func guidlineView() -> some View {
        VStack {
            VStack(spacing: 10) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(subTitle)
                    .lineLimit(2)
                    .lineSpacing(2.5)
                    .multilineTextAlignment(.center)
            }
            .foregroundStyle(Color.white)
            
            Spacer().frame(height: 453)
            
            Button(action: {
                dismiss()
            }, label: {
                Text("나가기")
                    .font(.body)
                    .foregroundStyle(Color.black)
                    .padding(30)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                    }
            })
        }
    }
}

#Preview {
    ISBNScanncerView()
}
