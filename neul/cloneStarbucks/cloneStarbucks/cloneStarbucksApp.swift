//
//  cloneStarbucksApp.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/22/25.
//

import SwiftUI
import SwiftData
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct cloneStarbucksApp: App {
    @StateObject private var router = NavigationRouter()
    @StateObject private var parsingViewModel = JSONParsingViewModel()
    @StateObject private var mapViewModel = MapViewModel()
    
    init() {
        KakaoSDK.initSDK(appKey: Config.nativeAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                SplashView()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .signUp:
                            SignUpView()
                        case .login:
                            LoginView()
                        case .coffeeDetail(let detail):
                            CoffeeDetailView(coffee: detail)
                        case .goToTab:
                            TabBarView()
                        case .ad:
                            AdvertiseView()
                        case .addReceipt:
                            ReceiptView()
                        case .storeMap:
                            MapContainerView()
                        }
                    }
                    .onOpenURL(perform: { url in
                        print(url)
                        if (AuthApi.isKakaoTalkLoginUrl(url)) {
                            AuthController.handleOpenUrl(url: url)
                        }
                    })
            }
            .environmentObject(router)
            // router는 @ObservedObject가 아니고, 굳이 상태추적하거나 바인딩할 필요가 없기 때문에 @Environment로 넘겨주는 거임.
            // 이었는데...Environment 쓰려면 Environment key 추가해야 하는데 그건 정의에 맞지 않는 것 같아서 Object로 선회.
            .environmentObject(parsingViewModel)
            .environmentObject(mapViewModel)
            .modelContainer(for: ReceiptModel.self)
            
        }
    }
}
