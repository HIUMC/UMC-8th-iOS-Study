//
//  BindableView.swift
//  week2Practice
//
//  Created by tokkislove on 3/28/25.
//

import SwiftUI
import Observation

@Observable
class BindableCounter {
    var count = 0
}

// 이 두 뷰에서 모두 BindableCounter의 count 값에 접근
struct BindableView: View {
    private var counter = BindableCounter()
    
    var body: some View {
        VStack {
            Text("count: \(counter.count)")
            Button("increment") {
                counter.count += 1
            }
            ChildView(counter: counter)
        }
        
    }
}


struct ChildView: View {
    @Bindable var counter: BindableCounter
    
    var body: some View {
        Button("child increment") {
            counter.count += 1
        }
    }
}



#Preview {
    BindableView()
}



