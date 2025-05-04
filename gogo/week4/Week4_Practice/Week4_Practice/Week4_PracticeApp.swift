//
//  Week4_PracticeApp.swift
//  Week4_Practice
import SwiftUI
import SwiftData

@main
struct _st_PracticeApp: App {
    var body: some Scene {
        WindowGroup {
            ReceiptsView()
        }
        .modelContainer(for: ReceiptsModel.self)
    }
}
