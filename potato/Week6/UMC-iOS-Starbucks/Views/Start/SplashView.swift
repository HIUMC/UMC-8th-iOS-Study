//
//  SplashView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/30/25.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject private var router: NavigationRouter
    let keychain = KeychainService.shared
    
    var body: some View {
        ZStack(alignment: .center) {
            Color("green01")
                .ignoresSafeArea()
            
            Image(.starbucksLogo)
                .resizable()
                .frame(maxWidth: 168, maxHeight: 168)
                .aspectRatio(contentMode: .fit)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if let storedEmail = UserDefaults.standard.string(forKey: "userEmail") {
                    print("UserDefaults에 저장된 이메일: \(storedEmail)")
                    
                    if let userInfo = keychain.loadUserInfo(email: storedEmail) {
                        print("사용자 정보 불러오기 성공. 자동 로그인")
                        router.push(.tab)
                    } else {
                        print("keychain에서 사용자 정보 불러오기 실패. 로그인 화면 표시")
                        // KeyChain 정보가 없으므로 UserDefaults에 저장된 이메일 정보 삭제
                        UserDefaults.standard.removeObject(forKey: "userEmail")
                        router.push(.login)
                    }
                } else {
                    print("UserDefaults에 저장된 이메일 없음. 로그인 화면 표시.")
                    router.push(.login)
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
