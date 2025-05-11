//
//  BottomView.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

struct BottomView: View {
    //@StateObject var viewModel: TextViewModel
    @ObservedObject var viewModel: TextViewModel
    // 여기서 뭘로 선언하느냐에 따라 에러 나고 안나고가 갈림.. 
    
    init(viewModel: TextViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("하위 뷰 입니다.")
            Text("현재 입력된 값 : \(viewModel.inputText)")
            Button("강제 초기화") {
                viewModel.inputText = "초기화됨"
            }
            Spacer()
        }
    }
}

