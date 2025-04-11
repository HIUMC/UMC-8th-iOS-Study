//
//  SwiftDataStudyApp.swift
//  SwiftDataStudy
//
//  Created by 박정환 on 4/9/25.
//


import SwiftUI
import SwiftData

@main
struct SwiftDataPracticeApp: App {
    var body: some Scene {
            WindowGroup {
                ContentView()
            }
            .modelContainer(for: Task.self) // 나는 Task라는 모델을 저장하고 불러올거야!! 그러니까 이 모델을 위한 저장소를 준비해줘!! 라고 말하는 거에요! 중요합니다!! 꼭 작성해야 돼요!!
        }
}
