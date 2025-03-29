//
//  OtherView.swift
//  Starbucks
//
//  Created by nau on 3/26/25.
//

import SwiftUI

struct OtherView: View {
    @StateObject var viewModel = SignupViewModel()
    
    var body: some View {
        VStack {
            topView
            
            ZStack {
                Color(.white01).ignoresSafeArea()
                
                VStack(spacing: UIScreen.screenSize.height/23) {
                    Spacer()
                    
                    middleView
                    
                    payView
            
                    serviceView
                }.frame(width: UIScreen.screenSize.width/1.12)
            }
        }
    }
    
    //()님 환영합니다! 부터 아래 3개 버튼까지
    private var topView: some View {
        HStack {
            Text("Other")
                .font(.mainTextBold24)
            
            Spacer()
            
            Button(action: {
                print("로그아웃")
            }, label: {
                Image(.logout)
            })
        }.frame(width: UIScreen.screenSize.width/1.12)
    }
    
    private var middleView: some View {
        VStack {
            Group {
                topText
                Text("환영합니다!")
            }.font(.mainTextSemibold24)
            
            Spacer()
            
            topBtnView
        }
    }
    
    private var topText: some View {
        HStack {
            Text("\(viewModel.nickname)")
                .foregroundStyle(Color(.green01))
            Text("님")
        }
    }
    
    private var topBtnView: some View {
        HStack {
            otherTopBtn(image: .starhistory, text: "별 히스토리", action: {print("별 히스토리")})
            
            otherTopBtn(image: .receipt, text: "전자영수증", action: {print("전자영수증")})
            
            otherTopBtn(image: .mymenu, text: "나만의 메뉴", action: {print("나만의 메뉴")})
        }
    }
    
    private var payView: some View {
        VStack(alignment: .leading, spacing: UIScreen.screenSize.height/33) {
            Text("Pay")
                .font(.mainTextSemiBold18)
            HStack() {
                VStack(alignment: .leading, spacing: UIScreen.screenSize.width/14) {
                    otherMenuBtn(image: .icon0, text: "스타벅스 카드 등록", action: {print("스타벅스 카드 등록")})
                    otherMenuBtn(image: .icon2, text: "쿠폰 등록", action: {print("쿠폰 등록")})
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: UIScreen.screenSize.width/14) {
                    otherMenuBtn(image: .icon1, text: "카드 교환권 등록", action: {print("카드 교환권 등록")})
                    otherMenuBtn(image: .icon3, text: "쿠폰 히스토리", action: {print("쿠폰 히스토리")})
                }
                
            }
            Divider()
        }
    }
    
    private var serviceView: some View {
        VStack(alignment: .leading, spacing: UIScreen.screenSize.height/33) {
            Text("고객지원")
                .font(.mainTextSemiBold18)
            HStack() {
                VStack(alignment: .leading, spacing: UIScreen.screenSize.width/14) {
                    otherMenuBtn(image: .icon4, text: "스토어 케어", action: {print("스토어 케어")})
                    otherMenuBtn(image: .icon5, text: "매장 정보", action: {print("매장 정보")})
                    otherMenuBtn(image: .icon6, text: "마이 스타벅스 리뷰", action: {print("마이 스타벅스 리뷰")})
                    Spacer()
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: UIScreen.screenSize.width/14) {
                    otherMenuBtn(image: .icon7, text: "고객의 소리", action: {print("고객의 소리")})
                    otherMenuBtn(image: .icon8, text: "반납기 정보", action: {print("반납기 정보")})
                    Spacer()//정렬 되도록.. 맨위 topView와 아래뷰 사이도 Spacer() 넣어줌
                }
            }
        }
    }
}

struct otherTopBtn: View {
    let image: ImageResource
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 12) {
                Image(image)
                Text(text)
            }
        }.buttonStyle(otherTopBtnStyle())
    }
}

struct otherMenuBtn: View {
    let image: ImageResource
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(image)
                Text(text)
                    .font(.mainTextSemibold16)
                    .lineLimit(1)
            }.tint(Color(.black02))
        }
        .frame(maxWidth: 153, alignment: .leading)
    }
}

#Preview {
    OtherView()
}
