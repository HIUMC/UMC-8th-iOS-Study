//
//  OtherView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/27/25.
//

import SwiftUI

struct OtherView: View {
    @AppStorage("nickname") private var storedNickname = ""
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    var body: some View {
        VStack {
            // 상단 헤더 영역
            Spacer().frame(height: 40)
            HStack {
                Text("Other")
                    .font(.mainTextBold24)
                Spacer()
                
                NavigationLink(destination: LoginView()) {
                    Image("logout")
                }
            }
            .padding(.horizontal, 23.5)
            .background(Color.white)
            VStack {
                VStack(alignment: .center) {
                    HStack(spacing: 0) {
                        Text(storedNickname.isEmpty ? "(작성한 닉네임)" : storedNickname)
                            .foregroundStyle(Color.green01)
                            .font(.mainTextSemibold24)
                        Text("님")
                            .font(.mainTextSemibold24)
                    }
                    Text("환영합니다! 🙌🏻")
                        .font(.mainTextSemibold24)
                }
                .multilineTextAlignment(.center)
                .padding(.top, 41)
                
                HStack {
                    boxView(text: "별 히스토리")
                    boxView(text: "전자영수증", destination: AnyView(ReceiptScreen()))
                    boxView(text: "나만의 메뉴")
                }
                
                VStack {
                    Text("Pay")
                        .font(.mainTextSemiBold18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer().frame(height: 24)
                    VStack(spacing: 32) {
                        HStack {
                            leftImageView(text: "스타벅스 카드 등록")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            leftImageView(text: "카드 교환권 등록")
                                .frame(maxWidth: .infinity)
                        }
                        HStack {
                            leftImageView(text: "쿠폰 등록")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            leftImageView(text: "쿠폰 히스토리")
                                .frame(maxWidth: .infinity)
                        }
                    }
                    Rectangle()
                        .frame(height: 0.7)
                        .padding(.bottom, 49)
                        .foregroundStyle(Color.black.opacity(0.12))
                    Text("고객지원")
                        .font(.mainTextSemiBold18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer().frame(height: 24)
                    VStack(alignment: .leading, spacing: 32) {
                        HStack {
                            leftImageView(text: "스토어 케어")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            leftImageView(text: "고객의 소리")
                                .frame(maxWidth: .infinity)
                        }
                        HStack {
                            leftImageView(text: "매장 정보")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            leftImageView(text: "반납기 정보")
                                .frame(maxWidth: .infinity)
                        }
                        HStack {
                            leftImageView(text: "마이 스타벅스 리뷰")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("")
                        }
                        Spacer().frame(height: 57)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white00)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct boxView: View {
    var text: String
    var destination: AnyView? = nil
    
    var body: some View {
        Group {
            if let destination = destination {
                NavigationLink(destination: destination) {
                    boxContent
                }
            } else {
                Button(action: {
                    print(text)
                }) {
                    boxContent
                }
            }
        }
    }
    
    var boxContent: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .frame(width: 102, height: 108)
            .overlay(
                VStack {
                    Image(pickImage(text))
                    Text(text)
                        .font(.mainTextSemibold16)
                        .foregroundStyle(Color.black03)
                }
            )
    }
    
    func pickImage(_ text: String) -> String {
        switch text {
        case "별 히스토리":
            return "star"
        case "전자영수증":
            return "bill"
        case "나만의 메뉴":
            return "cup"
        default:
            return "pay"
        }
    }
}

struct leftImageView: View {
    var text: String
    var body: some View {
        Button(action: {
            print(text)
        }) {
            HStack {
                Image(payImage(text))
                Text(text)
                    .font(.mainTextSemibold16)
                    .foregroundStyle(Color.black02)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    func payImage(_ text: String) -> String {
        switch text {
        case "스타벅스 카드 등록":
            return "card"
        case "쿠폰 등록":
            return "coupon"
        case "카드 교환권 등록":
            return "cardChange"
        case "쿠폰 히스토리":
            return "history"
        case "스토어 케어":
            return "store"
        case "고객의 소리":
            return "customer"
        case "매장 정보":
            return "shopInfo"
        case "마이 스타벅스 리뷰":
            return "review"
        case "반납기 정보":
            return "returnInfo"
        default:
            return "pay"
        }
    }
}

#Preview {
    OtherView()
}
