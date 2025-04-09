//
//  CounterView.swift
//  UMC-iOS-WorkBook
//
//  Created by 곽은채 on 3/25/25.
//

import SwiftUI

//struct CounterView: View {
//    @State private var isClicked: Int = 0
//
//    var body: some View {
//        VStack {
//            Text("현재 State 변수 값: \(isClicked)")
//            
//            CustomButton(isClicked: $isClicked)
//        }
//    }
//}

struct CounterView: View {
    @StateObject var viewModel: CounterViewModel = .init()

    var body: some View {
        VStack {
            Text("\(viewModel.count)")
            
            Button(action: {
                viewModel.count += 1
            }, label: {
                Text("카운트 증가 버튼")
            })
        }
    }
}

#Preview {
    CounterView()
}
