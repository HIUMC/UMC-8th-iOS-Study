//
//  OtherView.swift
//  Starbucks
//
//  Created by 이가원 on 3/29/25.
//

import SwiftUI

struct OtherView: View {
    @AppStorage("Nickname") private var nickname: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @State private var isReceiptActive: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                topView
                Spacer()
                middleView
                Spacer()
                payView
                Spacer()
                customView
                Spacer().frame(height: 92)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray7)
            .navigationDestination(isPresented: $isReceiptActive) {
                ReceiptsView()
            }
        }
    }

    private var topView: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Other")
                    .font(.custom("Pretendard-Bold", size: 24))
                Spacer()
                Button(action: { isLoggedIn = false }) {
                    Image(.logout)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }

    private var middleView: some View {
        Group {
            HStack {
                Text("\(nickname.isEmpty ? "(작성한 닉네임)" : nickname)")
                    .font(.custom("Pretendard-SemiBold", size: 24))
                    .foregroundColor(Color.green1)
                Text("님")
                    .font(.custom("Pretendard-SemiBold", size: 24))
            }
            Text("환영합니다! 🙌🏻")
                .font(.custom("Pretendard-SemiBold", size: 24))
            HStack(spacing: 10.5) {
                MenuBtn(image: .starHistory, title: "별 히스토리")
                MenuBtn(image: .receipt, title: "전자영수증") {
                    isReceiptActive = true
                }
                MenuBtn(image: .my, title: "나만의 메뉴")
            }
        }
    }

    private var payView: some View {
        VStack {
            HStack {
                Text("Pay")
                    .font(.custom("Pretendard-SemiBold", size: 18))
                Spacer()
            }
            .padding(.horizontal, 10)

            VStack(spacing: 32) {
                HStack {
                    Btn(image: .card, title: "스타벅스 카드 등록")
                    Spacer()
                    Btn(image: .cardChange, title: "카드 교환권 등록")
                }
                HStack {
                    Btn(image: .coupon, title: "쿠폰 등록")
                    Spacer()
                    Btn(image: .conponHistory, title: "쿠폰 히스토리")
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 16)

            Divider()
                .frame(width: 320)
                .padding(.leading, 10)
        }
    }

    private var customView: some View {
        VStack {
            HStack {
                Text("고객 지원")
                    .font(.custom("Pretendard-SemiBold", size: 18))
                Spacer()
            }
            .padding(.horizontal, 10)

            VStack(spacing: 32) {
                HStack {
                    Btn(image: .storeCare, title: "스타벅스 카드 등록")
                    Spacer()
                    Btn(image: .customer, title: "카드 교환권 등록")
                }
                HStack {
                    Btn(image: .storeInfo, title: "매장 정보")
                    Spacer()
                    Btn(image: .returnInfo, title: "반납기 정보")
                }
                HStack {
                    Btn(image: .myReview, title: "마이 스타벅스 리뷰")
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
            .padding(.top, 16)
        }
    }

    struct MenuBtn: View {
        let image: ImageResource
        let title: String
        var action: (() -> Void)? = nil

        var body: some View {
            Button(action: {
                action?()
            }) {
                VStack(spacing: 4) {
                    Spacer().frame(height: 19)
                    Image(image)
                    Text(title)
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .foregroundStyle(Color.black)
                    Spacer().frame(height: 19)
                }
                .frame(width: 102, height: 108)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(color: Color.black.opacity(0.1), radius: 5)
            }
        }
    }

    struct Btn: View {
        let image: ImageResource
        let title: String

        var body: some View {
            Button(action: {
                print(title)
            }) {
                HStack(spacing: 4) {
                    Image(image)
                    Text(title)
                        .font(.custom("Pretendard-SemiBold", size: 16))
                        .foregroundStyle(Color.black)
                }
                .frame(width: 157, height: 32, alignment: .leading)
            }
        }
    }
}

#Preview {
    OtherView()
}
