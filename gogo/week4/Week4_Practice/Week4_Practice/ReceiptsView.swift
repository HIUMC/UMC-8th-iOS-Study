//
//  ReceiptsView.swift
//  4st_Practice
//
//  Created by Apple Coding machine on 4/1/25.
//

import SwiftUI
import Observation

struct ReceiptsView: View {
    
    @Bindable var viewModel: ReceiptsViewModel = .init()
    
    var body: some View {
        VStack(spacing: 42) {
            HStack {
                ForEach(ReceiptSegment.allCases, id: \.id) { segment in
                    topSegment(segment: segment)
                }
            }
            
            tabView
        }
        .frame(maxWidth: 337, maxHeight: .infinity)
    }
    
    @ViewBuilder
    func topSegment(segment: ReceiptSegment) -> some View {
        VStack(spacing: 0) {
            HStack {
                Text(segment.title)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)
                    .padding(.trailing, 0.0)
                    .foregroundStyle(Color.black)
                    .font(.system(size: 40))
                    .onTapGesture {
                        viewModel.selectedSegment = segment
                    }
            }
            if viewModel.selectedSegment == segment {
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 116, height: 2)
            }
        }
        .frame(maxWidth: .infinity)
        
        if segment == .first {
            Spacer()
        }
    }
    
    private var tabView: some View {
        TabView(selection: $viewModel.selectedSegment, content: {
            ForEach(ReceiptSegment.allCases, id: \.id) { segment in
                VStack(spacing: 10) {
                    Image(segment.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 490)
                    
                    if viewModel.selectedSegment == segment {
                        if let receipt = viewModel.currentReceipt {
                            ReceiptInfoView(receipt: receipt)
                        } else {
                            ProgressView("OCR 처리 중...")
                                .accessibilityLabel(/*@START_MENU_TOKEN@*/"Label"/*@END_MENU_TOKEN@*/)
                                .accessibilityIdentifier(/*@START_MENU_TOKEN@*/"Identifier"/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
                .tag(segment)
                .task {
                    viewModel.startOCR(segment)
                }
            }
        })
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    ReceiptsView()
}
