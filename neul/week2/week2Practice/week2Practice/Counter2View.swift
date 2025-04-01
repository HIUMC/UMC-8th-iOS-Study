//
//  Counter2View.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI

struct Counter2View: View {
    var viewModel: Counter2ViewModel = .init()
    
    var body: some View {
        VStack {
            Text("\(viewModel.count)")
            
            Button(action: {
                viewModel.count += 1
            }) {
                Text("카운트 증가합니다.")
            }
            .padding()
        }
        
        
        
    }
}

#Preview {
    Counter2View()
}
