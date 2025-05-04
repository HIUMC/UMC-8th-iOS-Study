//
//  ContentView.swift
//  week3Practice
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct ContentView: View {
    @State private var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(0..<50, id: \.self) { index in
                            Text("아이템: \(index)")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.black)
                                .background(Color.pink.opacity(0.5))
                                .id(index) // 해당 뷰에 고유한 식별자 부여
                                .padding()
                        }
                    }
                }
                .onChange(of: scrollToIndex) { oldValue, newValue in
                    withAnimation {
                        //여기서 위에서 부여한 id 사용
                        //anchor: top -> 그 항목을 위에 위치시키겠다
                        proxy.scrollTo(newValue, anchor: .top)
                    }
                }
            }
            
            HStack {
                Button("top") { scrollToIndex = 0 }
                Button("middle") { scrollToIndex = 25 }
                Button("bottom") { scrollToIndex = 49 }
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
