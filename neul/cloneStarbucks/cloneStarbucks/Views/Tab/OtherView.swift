//
//  OtherView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct OtherView: View {
    @AppStorage("nickname") private var nickname: String = "(작성한 닉네임)"
    private var viewModel: SignUpViewModel = .init()
    
    var body: some View {
        ZStack {
            Color(hex: "F8F8F8")
            VStack {
                navigationBar
                userWelcome
                    .padding(.top, 41)
                Spacer()
                userMenu
                Spacer()
                payMenu
                Divider()
                    .frame(height: 1)
                    .overlay(.black.opacity(0.12))
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
                customerMenu
                    .padding(.bottom, 61)
                Spacer()
                
            }
            .padding(.top, 25)
            
        }
        .ignoresSafeArea(.all)
        
    }
    
    
    
    private var navigationBar: some View {
            VStack {
                Spacer()
                HStack {
                    Text("Other")
                        .font(.MainTextBold24)
                        .foregroundStyle(.black)
                        .padding(.leading, 23.5)
                        .padding(.bottom, 16)
                    Spacer()
                    Button(action: {
                        print("로그아웃")
                    }, label: {
                        Image(.logout)
                            .resizable()
                            .frame(width: 35, height: 35)
                    })
                    .padding(.trailing, 23.5)
                    .padding(.bottom, 16)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .top)
            .background(Color.white)
    }
    
    private var userWelcome: some View {
        VStack(spacing: 5) {
            HStack(spacing: 2) {
                Group {
                    Text("\(nickname)")
                        .foregroundStyle(Color.green01)
                    Text("님")
                        .foregroundStyle(Color.black02)
                }
                .font(.MainTextSemiBold24)
                
            }
            Text("환영합니다! 🙌🏻")
                .foregroundStyle(Color.black02)
                .font(.MainTextSemiBold24)
        }
    }
    
    private var userMenu: some View {
        HStack(spacing: 10.5) {
            UserButton(image: "starHistory", title: "별 히스토리")
            UserButton(image: "receipt", title: "전자영수증")
            UserButton(image: "myMenu", title: "나만의 메뉴")
        }
    }
    
    private var payMenu: some View {
        VStack {
            HStack {
                Text("Pay")
                    .font(.MainTextSemiBold18)
                    .kerning(-0.3)
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding(.bottom, 8)
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    OtherViewButton(image: "card", title: "스타벅스 카드 등록")
                    OtherViewButton(image: "coupon", title: "쿠폰 등록")
                }
                Spacer()
                VStack(alignment: .leading, spacing: 16) {
                    OtherViewButton(image: "cardChange", title: "카드 교환권 등록")
                    OtherViewButton(image: "couponHistory", title: "쿠폰 히스토리")
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var customerMenu: some View {
        VStack {
            HStack {
                Text("고객지원")
                    .font(.MainTextSemiBold18)
                    .kerning(-0.3)
                    .foregroundStyle(.black)
                Spacer()
            }
            .padding(.bottom, 8)
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 16) {
                    OtherViewButton(image: "storeCare", title: "스토어 케어")
                    OtherViewButton(image: "storeInfo", title: "매장 정보")
                    OtherViewButton(image: "myReview", title: "마이 스타벅스 리뷰")
                }
                Spacer()
                VStack(alignment: .leading, spacing: 16) {
                    OtherViewButton(image: "customerVoice", title: "고객의 소리")
                    OtherViewButton(image: "returnInfo", title: "반납기 정보")
                }
                .padding(.trailing, 30)
            }
        }
        .padding(.horizontal, 20)
    }
}

struct OtherView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            OtherView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
