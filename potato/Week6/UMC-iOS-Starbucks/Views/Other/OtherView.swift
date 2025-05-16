//
//  OtherView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

struct OtherView: View {
    @EnvironmentObject private var router: NavigationRouter
    
//    @AppStorage("nickname") private var nickname: String?
    let keychain = KeychainService.shared
    @State var nickname: String?
    
    var body: some View {
        VStack {
            topNav
            Spacer(minLength: 41)
            welcome
            Spacer(minLength: 41)
            pay
            Divider()
                .padding(.horizontal, 20)
            Spacer(minLength: 41)
            support
            Spacer(minLength: 41)
        }
        .navigationBarBackButtonHidden(true)
        .background(Color("white01"))
        .onAppear {
            if let userEmail = UserDefaults.standard.string(forKey: "userEmail") {
                if let userInfo = keychain.loadUserInfo(email: userEmail) {
                    nickname = userInfo.nickname
                }
            }
        }
    }
    
    private var topNav: some View {
        HStack {
            Text("Other")
                .font(.mainTextBold24)
                .foregroundStyle(Color("black00"))
            Spacer()
            Button(action: {
                if let loggedInUserEmail = UserDefaults.standard.string(forKey: "userEmail") {
                    keychain.deleteUser(email: loggedInUserEmail)
                    UserDefaults.standard.removeObject(forKey: "userEmail")
                    print("로그아웃 성공")
                    router.push(.login)
                }
            }, label: {
                Image(.logout)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .foregroundStyle(Color("black00"))
            })
        }
        .padding(.horizontal, 23.5)
        .padding(.vertical, 16)
        .background(Color("white00"))
    }
    
    private var welcome: some View {
        VStack(spacing: 24) {
            VStack(spacing: 5) {
                Group {
                    Text("\(nickname ?? "(작성한 닉네임)") 님")
                        .foregroundStyle(Color("green01"))
                    Text("환영합니다! 🙌")
                        .foregroundStyle(Color("black01"))
                }
                .font(.mainTextSemiBold24)
            }
            
            HStack(spacing: 10.5) {
                WelcomeView(cardLabel: "별 히스토리", img: "star")
                WelcomeView(cardLabel: "전자영수증", img: "receipt") {
                    router.push(.receipts)
                }
                WelcomeView(cardLabel: "나만의 메뉴", img: "menu")
            }
        }
    }
    
    private var pay: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Pay")
                .font(.mainTextSemiBold18)
                .foregroundStyle(Color("black00"))
            
            VStack(spacing: 0) {
                Group {
                    HStack {
                        MenuItemView(img: "pay01", menuLabel: "스타벅스 카드 등록")
                        Spacer()
                        MenuItemView(img: "pay02", menuLabel: "카드 교환권 등록")
                    }
                    
                    HStack {
                        MenuItemView(img: "pay03", menuLabel: "쿠폰 등록")
                        Spacer()
                        MenuItemView(img: "pay04", menuLabel: "쿠폰 히스토리")
                    }
                }
                .padding(.vertical, 16)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var support: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("고객지원")
                .font(.mainTextSemiBold18)
                .foregroundStyle(Color("black00"))
            
            VStack(spacing: 0) {
                Group {
                    HStack {
                        MenuItemView(img: "support01", menuLabel: "스토어 케어")
                        Spacer()
                        MenuItemView(img: "support02", menuLabel: "고객의 소리")
                    }
                    
                    HStack {
                        MenuItemView(img: "support03", menuLabel: "매장 정보") {
                                router.push(.findStore)
                            }
                        Spacer()
                        MenuItemView(img: "support04", menuLabel: "반납기 정보")
                    }
                    
                    HStack {
                        MenuItemView(img: "support05", menuLabel: "마이 스타벅스 리뷰")
                        Spacer()
                    }
                }
                .padding(.vertical, 16)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    OtherView()
}
