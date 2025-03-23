//
//  CounterView.swift
//  exampleStack
//
//  Created by 이서현 on 3/23/25.
//

import SwiftUI


struct StatePropertyView: View {
    @State private var count = 0  // 상태 프로퍼티 선언

    var body: some View {
        VStack {
            Text("카운트: \(count)") // 값이 변경되면 자동 업데이트
                .font(.largeTitle)

            Button("증가") {
                count += 1  // 상태 변경 시 UI 자동 업데이트
            }
            .padding()
        }
    }
}

#Preview {
    StatePropertyView()
}
