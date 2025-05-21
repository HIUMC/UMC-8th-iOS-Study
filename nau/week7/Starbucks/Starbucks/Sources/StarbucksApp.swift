import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct StarbucksApp: App {
    init() {
        // kakao sdk 초기화
        let kakaoAppKey = (Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String) ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
