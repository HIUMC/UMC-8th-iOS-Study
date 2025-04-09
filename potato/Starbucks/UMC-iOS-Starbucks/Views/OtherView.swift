//
//  OtherView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 3/31/25.
//

import SwiftUI

struct OtherView: View {
    @AppStorage("nickname") private var nickname
    : String?
    @State private var router = NavigationRouter()
    
    var body: some View {
        VStack {
            topNav
            Spacer(minLength: 41)
            welcome
            Spacer(minLength: 41)
            pay
            Spacer(minLength: 41)
            support
            Spacer(minLength: 41)
        }
        .navigationBarBackButtonHidden(true)
        .background(Color("white01"))
    }
    
    private var topNav: some View {
        HStack {
            Text("Other")
                .font(.mainTextBold24)
                .foregroundStyle(Color("black00"))
            Spacer()
            NavigationLink(destination: LoginView()) {
                Image(.logout)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .foregroundStyle(Color("black00"))
            }
            /*
            Button(action: {
                print("로그아웃")
                router.push(.login)
            }, label: {
                Image(.logout)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35)
                    .foregroundStyle(Color("black00"))
            })
             */
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
                welcomeView(cardLabel: "별 히스토리", img: "star")
                welcomeView(cardLabel: "전자영수증", img: "receipt")
                welcomeView(cardLabel: "나만의 메뉴", img: "menu")
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
                        menuItemView(img: "pay01", menuLabel: "스타벅스 카드 등록")
                        Spacer()
                        menuItemView(img: "pay02", menuLabel: "카드 교환권 등록")
                    }
                    
                    HStack {
                        menuItemView(img: "pay03", menuLabel: "쿠폰 등록")
                        Spacer()
                        menuItemView(img: "pay04", menuLabel: "쿠폰 히스토리")
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
                        menuItemView(img: "support01", menuLabel: "스토어 케어")
                        Spacer()
                        menuItemView(img: "support02", menuLabel: "고객의 소리")
                    }
                    
                    HStack {
                        menuItemView(img: "support03", menuLabel: "매장 정보")
                        Spacer()
                        menuItemView(img: "support04", menuLabel: "반납기 정보")
                    }
                    
                    HStack {
                        menuItemView(img: "support05", menuLabel: "마이 스타벅스 리뷰")
                        Spacer()
                    }
                }
                .padding(.vertical, 16)
            }
        }
        .padding(.horizontal, 20)
    }
}

struct welcomeView: View {
    var cardLabel: String
    var img: String
    
    var body: some View {
        Button(action: {
            print(cardLabel)
        }, label: {
            VStack(spacing: 4) {
                Image(img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 38, height: 38)
                    .padding(5)
                
                Text(cardLabel)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(Color("black01"))
            }
        })
        .frame(width: 102, height: 70)
        .padding(.vertical, 19)
        .background() {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("white00"))
                .shadow(color: .black.opacity(0.1), radius: 2.5, x: 0, y: 0)
        }
    }
}

struct menuItemView: View {
    var img: String
    var menuLabel: String
    
    var body: some View {
        Button(action: {
            print(menuLabel)
        }, label: {
            HStack(spacing: 4) {
                Image(img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 32, height: 32)
                
                Text(menuLabel)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(Color("black01"))
            }
        })
        .frame(width: 157, height: 32, alignment: .leading)
    }
}

#Preview {
    OtherView()
}
