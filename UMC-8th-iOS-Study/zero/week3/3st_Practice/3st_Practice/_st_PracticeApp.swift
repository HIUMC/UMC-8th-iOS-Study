//
//  _st_PracticeApp.swift
//  3st_Practice
//
//  Created by 김영택 on 4/3/25.
//

import SwiftUI
import Observation

@main
struct _st_PracticeApp: App {
    @State private var viewModel = RainbowViewModel() // RainbowViewModel 인스턴스 생성
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RainbowView(viewModel: viewModel) // ContentView에 ViewModel 전달
            }
        }
    }
}
