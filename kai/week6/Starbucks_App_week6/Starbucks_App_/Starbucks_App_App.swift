//
//  Starbucks_App_App.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/20/25.
//

import SwiftUI
import KakaoSDKCommon

@main
struct StarbucksApp: App {
    
    //이니셜라이저는 구조체 맨 위에 위치해야 한다
    init() {
            // kakao sdk 초기화
            let kakaoAppKey = (Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String) ?? ""
            KakaoSDK.initSDK(appKey: kakaoAppKey)
        }
    
    var body: some Scene {
        WindowGroup {
        }
        
        
    }
}


