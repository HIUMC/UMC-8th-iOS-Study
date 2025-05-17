//  _025_UMC_iOSApp.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 3/19/25.
//

import SwiftUI
import KakaoSDKCommon

@main
struct _025_UMC_iOSApp: App {
    @StateObject private var router = NavigationRouter()
    @StateObject private var detailViewModel = MenuDetailViewModel()
    
    init() {
            // kakao sdk 초기화
            let kakaoAppKey = (Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String) ?? ""
            KakaoSDK.initSDK(appKey: kakaoAppKey)
        }

    var body: some Scene {

        
        WindowGroup {
            NavigationStack(path: $router.path) {
                AppEntryView()
                    .environmentObject(router)
                    .environmentObject(detailViewModel)
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .signup:
                            SignupView()
                                .environmentObject(router)
                            
                        case .cafeMenu(let menu):
                            MenuDetailView(menu: menu)
                                .environmentObject(detailViewModel)
                                .environmentObject(router)
                            
                        case .receipt:
                            ReceiptView()
                                .environmentObject(router)
                            
                        case .home:
                            HomeView()
                                .environmentObject(router)
                        }
                    }
            }
        }
    }
}
