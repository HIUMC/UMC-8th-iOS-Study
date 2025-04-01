//
//  BasicNavView.swift
//  week3Practice
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI
import Observation // Combine 없이도 상태 변화 감지가 가능

struct BasicNavView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("디테일뷰로 가줘", destination: DetailView())
        }
    }
}

fileprivate struct DetailView: View {
    var body: some View {
        Text("디테일뷰")
            .navigationTitle("hello navi")
    }
}

#Preview {
    BasicNavView()
}
