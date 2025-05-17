//
//  week4ExtraApp.swift
//  week4Extra
//
//  Created by tokkislove on 4/7/25.
//

import SwiftUI
import SwiftData

@main
struct week4ExtraApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Task.self)
    }
}
