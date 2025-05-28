//
//  STARBUCKSApp.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/23/25.
//

import SwiftUI

@main
struct MyApp: App {
    @StateObject private var userManager = UserManager.shared

    var body: some Scene {
        WindowGroup {
            Group {
                if userManager.isLoggedIn {
                    iconView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(userManager) // 필요 시 자식 뷰에 공유 가능
        }
        .modelContainer(for: [ReceiptsModel.self, ReceiptsImageModel.self])
    }
}

