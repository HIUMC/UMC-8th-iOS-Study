//
//  ContentView.swift
//  week2Practice
//
//  Created by tokkislove on 3/25/25.
//

import SwiftUI

//MARK: @State
/*struct CounterView: View {
    @State private var isClicked: Bool = false
    var body: some View {
        VStack {
            Text("현재 state 변수 값: \(isClicked)")
            CustomButton(isClicked: $isClicked)
        }
    }
}*/

//MARK: @ObservedObject
/*struct CounterView: View {
    @ObservedObject var viewModel: CounterViewModel = .init()
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
            Button(action: {
                viewModel.count += 1
            }, label: {
                Text("카운트 증가 버튼")
            })
            .padding()
            Button(action: {
                viewModel.count -= 1
            }, label: {
                Text("카운트 감소 버튼")
            })
            .padding()
        }
    }
}*/

//MARK: @StateObject
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

