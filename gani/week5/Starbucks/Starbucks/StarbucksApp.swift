//
//  StarbucksApp.swift
//  Starbucks
//
//  Created by 이가원 on 3/24/25.
//
import SwiftUI

@main
struct StarbucksApp: App {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}
