//
//  ContentView.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
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
                            Text("Item \(index)")
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.3))
                                .id(index)
                                .padding()
                        }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation {
                            proxy.scrollTo(25, anchor: .center)
                        }
                    }
                }
            }
            
            HStack {
                Button("Top") { scrollToIndex = 0 }
                Button("Middle") { scrollToIndex = 25 }
                Button("Bottom") { scrollToIndex = 49 }
            }
        }
    }
}

#Preview {
    ContentView()
}
#Preview {
    ContentView()
}
