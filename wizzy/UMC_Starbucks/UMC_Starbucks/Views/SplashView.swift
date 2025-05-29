//
//  SplashView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var AutoLogin = false
    var body: some View {
        NavigationStack {
            Group {
                ZStack(alignment: .center) {
                    Color.loginButtonGreen.ignoresSafeArea(.all)
                    Image("Starbucks")
                    // sfsymbol 이미지가 아니면, Resizable 없이는 크기조정 불가
                        .resizable()
                        .frame(width: 168, height: 168)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                }
            }
            .opacity(isActive ? 0 : 1)
            .animation(.easeOut(duration: 1), value: isActive)
            .onAppear {
                // ✅ OSRM_BASE_URL 출력 확인
                if let urlString = Bundle.main.object(forInfoDictionaryKey: "OSRM_BASE_URL") as? String {
                    print("✅ SplashView에서 baseURL 확인됨: \(urlString)")
                } else {
                    print("❌ SplashView에서 baseURL을 못 찾음")
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if let token = KeychainService.shared.loadTokenInfo() {
                        print("자동 로그인: \(token.accessToken)")
                        AutoLogin = true
                        UserDefaults.standard.set(token.nickname, forKey: "nickname") // gpt
                    }
                    withAnimation {
                        isActive = true
                    }
                }
            }
            .navigationDestination(isPresented: $isActive) {
                if AutoLogin {
                    TabBarView()
                } else {
                    LoginView()
                }
            }
        }
    }
}


#Preview {
    SplashView()
}
