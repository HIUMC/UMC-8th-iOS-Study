import SwiftUI

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

                // ✅ 서버 검증 없이 바로 홈 화면으로 이동
                DispatchQueue.main.async {
                    router.push(.home)
                }
                return
            }
        }

        // 저장된 계정 없음 → 로그인 화면 보이게
        isChecking = false
    }

}
