//
//  ScrollOffsetView.swift
//  week3Practice
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

// offset이라는 개념.. 어렵다.
struct ScrollOffsetView: View {
    // 스크롤된 거리를 나타냄
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        VStack {
            Text("Offset: \(Int(scrollOffset))")
                .font(.headline)
            
            ScrollView {
                LazyVStack {
                    ForEach(0..<50, id: \.self) { index in
                        Text("item: \(index)")
                            .frame(maxWidth: .infinity)
                            .background(Color.pink.opacity(0.2))
                    }
                }
                
                /*
                 proxy.frame(in: .global)는 그 뷰가 전체 화면 기준으로 어디에 있는지를 알려줘
                 .minY는 그 뷰의 상단 위치 (Y값)을 가져오는 거야
                 -> 즉, 지금 화면에서 LazyVStack이 얼마나 위로 스크롤됐는지를 나타내는 거야.
                 */
                
                
                .background(
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                scrollOffset = proxy.frame(in: .global).minY
                            }
                            .onChange(of: proxy.frame(in: .global).minY) { oldValue, newValue in
                                scrollOffset = newValue
                            }
                    }
                )
            }
        }
    }
}

#Preview {
    ScrollOffsetView()
}
