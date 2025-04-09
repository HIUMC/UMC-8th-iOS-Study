//
//  ReceiptView.swift
//  week4Lab
//
//  Created by tokkislove on 4/7/25.
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
    }
    
    
    @ViewBuilder
    func topSegment(segment: ReceiptSegment) -> some View {
        VStack(spacing: 0) {
            Text(segment.title)
                .foregroundStyle(.black)
                .font(.system(size: 40))
                .onTapGesture {
                    viewModel.selectedSegment = segment
                }
            if viewModel.selectedSegment == segment {
                Rectangle()
                    .fill(.black)
                    .frame(width: 116, height: 2)
            }
        }
        .frame(maxWidth: .infinity)
        
        if segment == .first {
            Spacer()
        }
    }
    
    private var tabView: some View {
        TabView(selection: $viewModel.selectedSegment) {
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
                            ProgressView("OCR 처리 중 ...")
                        }
                    }
                }
                .tag(segment)
                .task {
                    viewModel.startOCR(segment)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    ReceiptsView()
}
