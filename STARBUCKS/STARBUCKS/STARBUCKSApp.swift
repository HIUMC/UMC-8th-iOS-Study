//
//  STARBUCKSApp.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/23/25.
//

import SwiftUI

@main
struct StarbucksApp: App {
    @State private var showSplash = true
    var body: some Scene {
            WindowGroup {
                if showSplash {
                    SplashView()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                showSplash = false
                            }
                        }
                } else {
                    LoginView()
                }
            }
        }
    }
