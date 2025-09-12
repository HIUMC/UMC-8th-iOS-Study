import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth

struct AppEntryView: View {
    @EnvironmentObject var router: NavigationRouter
    @State private var isChecking = true

    var body: some View {
        Group {
            if isChecking {
                ProgressView("자동 로그인 확인 중...")
            } else {
                LoginView()
            }
        }
        .onAppear {
            autoLogin()
        }
    }

    private func autoLogin() {
        let keychain = KeychainService.shared
        let service = "Starbucks"

        let accounts = keychain.getAllAccounts()
        for email in accounts {
            if let password = keychain.load(account: email, service: service) {
                print("Keychain 자동 로그인 정보 발견: \(email) / \(password)")

                // ✅ Kakao 토큰이 있는지 검사
                if AuthApi.hasToken() {
                    UserApi.shared.accessTokenInfo { (_, error) in
                        if error == nil {
                            print("✅ 카카오 토큰 유효 → 홈으로 이동")
                            DispatchQueue.main.async {
                                router.push(.home)
                            }
                        } else {
                            print("❌ 카카오 토큰 없음 또는 만료 → 로그인 화면")
                            isChecking = false
                        }
                    }
                } else {
                    print("❌ 카카오 토큰 없음 → 로그인 화면")
                    isChecking = false
                }

                return
            }
        }

        // 저장된 계정 없음 → 로그인 화면 보이게
        isChecking = false
    }


}
