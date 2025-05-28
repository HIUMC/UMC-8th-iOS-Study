import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct StarbucksApp: App {
    init() {
        // kakao sdk 초기화
        KakaoSDK.initSDK(appKey: BuildSetting.kakaoAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
