//
//  ContentView.swift
//  week8Practice
//
//  Created by tokkislove on 6/17/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            Text("이름: \(viewModel.name)")
                .font(.title)
            
            /// 얘가 변화 감지 -> sink 실행
            TextField("이름 입력", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
