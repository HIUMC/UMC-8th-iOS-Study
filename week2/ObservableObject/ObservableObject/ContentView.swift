//
//  ContentView.swift
//  observableObject
//
//  Created by 이서현 on 3/23/25.
//

/*
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: CounterViewModel = .init()
    
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
            
            Button(action: {
                viewModel.count += 1
            }, label: {
                Text("카운트 증가 버튼")
            })
        } //VStack end
    }
}

#Preview {
    ContentView()
}
*/

import SwiftUI
  
struct ContentView: View {
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
    ContentView()
}

