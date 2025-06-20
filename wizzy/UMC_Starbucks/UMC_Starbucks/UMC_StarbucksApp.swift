//
//  UMC_StarbucksApp.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI
import SwiftData
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

@main
struct UMC_StarbucksApp: App {
    init() {
        if let urlString = Bundle.main.object(forInfoDictionaryKey: "OSRM_BASE_URL") as? String {
            print("✅ baseURL: \(urlString)")
        }
        if let appKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_NATIVE_APP_KEY") as? String {
            KakaoSDK.initSDK(appKey: appKey)
        } else {
            print("❌ Kakao App Key 불러오기 실패")
        }

        var loginSuccess = false

        // Kakao 자동 로그인 시도
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { _, error in
                if let _ = error {
                    print("⛔️ 유효하지 않은 Kakao 토큰")
                } else {
                    print("✅ Kakao 자동 로그인 성공")
                    UserDefaults.standard.set(true, forKey: "isLoginOK")
                }
            }
        }

        // 이메일(Keychain) 로그인 시도
        if let saved = KeychainService.shared.loadTokenInfo() {
            print("✅ 키체인 자동 로그인 정보 확인됨: \(saved.nickname)")
            loginSuccess = true
        }

        // 결과 반영
        UserDefaults.standard.set(loginSuccess, forKey: "isLoginOK")
    }
    
    @AppStorage("isLoginOK") var isLoginOK: Bool = false
    var body: some Scene {
        WindowGroup {
            SplashView()
                .onOpenURL { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
                .modelContainer(for: [CardModel.self])
                .onAppear {
                    let container = try? ModelContainer(for: CardModel.self)
                    let context = container?.mainContext

                    guard let context else {
                        print("❌ 모델 컨텍스트 로드 실패")
                        return
                    }

                    let sampleCards = [
                        CardModel(
                            imageName: "cardImage",
                            cardName: "스타벅스 카드 A",
                            cardMoney: 10000,
                            cardNumber: "1234-5678-9012-3456",
                            activationDate: Date()
                        ),
                        CardModel(
                            imageName: "cardImage",
                            cardName: "스타벅스 카드 B",
                            cardMoney: 20000,
                            cardNumber: "2345-6789-0123-4567",
                            activationDate: Date()
                        ),
                        CardModel(
                            imageName: "cardImage",
                            cardName: "스타벅스 카드 C",
                            cardMoney: 30000,
                            cardNumber: "3456-7890-1234-5678",
                            activationDate: Date()
                        )
                    ]
                    sampleCards.forEach { context.insert($0) }
                    try? context.save()
                    print("✅ 샘플 카드 3개 삽입 완료 (항상 새로 삽입)")
                }
        }
    }
}
