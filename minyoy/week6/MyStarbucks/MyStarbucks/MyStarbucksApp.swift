//
//  MyStarbucksApp.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/19/25.
//

import SwiftUI
import SwiftData
import KakaoSDKCommon

@main
struct MyStarbucksApp: App {
    init() {
        KakaoSDK.initSDK(appKey: "\(Config.nativeAppKey)")
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [ReceiptsModel.self, ReceiptsImageModel.self])
    }
}
