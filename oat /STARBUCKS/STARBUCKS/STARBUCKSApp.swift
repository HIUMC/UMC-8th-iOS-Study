//
//  STARBUCKSApp.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/23/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct MyApp: App {
    @StateObject private var userManager = UserManager.shared
    @State private var isLoggedIn = false


    var body: some Scene {
        WindowGroup {
            Group {
                if userManager.isLoggedIn {
                    iconView()
                } else {
                    LoginView()
                }
            }
        }
        .modelContainer(for: [ReceiptsModel.self, ReceiptsImageModel.self])
    }

}


