//
//  RouteView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/22/25.
//

import SwiftUI

struct RouteView: View {
    @StateObject var viewModel = RouteViewModel()

    var body: some View {
        VStack(spacing: 12) {
            Text("거리: \(viewModel.distance / 1000, specifier: "%.2f") km")
            Text("예상 시간: \(viewModel.duration / 60, specifier: "%.1f") 분")
        }
        .onAppear {
            viewModel.fetchRoute(
                start: (126.9784, 37.5665), // 서울시청
                end: (127.0276, 37.4979)    // 강남역
            )
        }
    }
}


#Preview {
    RouteView()
}
