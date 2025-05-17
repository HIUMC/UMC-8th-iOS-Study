//
//  TopView.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

struct TopView: View {
    @StateObject var viewModel: TextViewModel = .init()
    @State private var showBottomView = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("상위뷰 입니다.")
                Text("텍스트 입력 값: \(viewModel.inputText)")
                TextField("입력창입니다", text: $viewModel.inputText)
                    .frame(width: 350)
                
                Button("하위 뷰 부르기 버튼") {
                    showBottomView.toggle()
                }
                .sheet(isPresented: $showBottomView) {
                    BottomView(viewModel: viewModel) // 여기서 Init되는 거! 
                }
            }
        }
        
        
        
    }
}

#Preview {
    TopView()
}
