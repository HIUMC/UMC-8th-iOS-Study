//
//  UMC_iOS_WorkBook_Extra_4App.swift
//  UMC-iOS-WorkBook-Extra-4
//
//  Created by 곽은채 on 4/5/25.
//

import SwiftUI
import SwiftData

@main
struct UMC_iOS_WorkBook_Extra_4App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self) // 이 모델 쓸테니 저장소 준비해라
    }
}
