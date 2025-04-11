//
//  OtherView.swift
//  Starbucks
//
//  Created by 박정환 on 3/31/25.
//

import Foundation
import Observation
import SwiftUI

struct OtherView: View {
    @AppStorage("nickname") private var nickname: String = "(작성한 닉네임)"
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        VStack {
            topView
            contentView
        }
    }
    
    private var topView: some View {
        HStack {
            Text("Other")
                .foregroundStyle(.black)
                .font(.mainTextBold24)
            
            Spacer()
                .frame(width: 295)
            
            Button(action: {
                print("로그아웃")
            }, label: {
                Image("logout")
                    .resizable()
                    .frame(width: 35, height: 35)
            })
        }
        .background(.white)
    }
    
    private var contentView: some View {
        VStack {
            infoView
            
            Spacer()
            
            payView
            
            Spacer()
            
            supportView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 41)
        .background(Color("white01"))
    }
    
    //cotentView 코드
    private var infoView: some View {
        VStack {
            VStack(spacing: 5) {
                HStack {
                    Text(nickname.isEmpty ? "(작성한 닉네임)" : nickname)
                        .foregroundStyle(Color("green01"))
                        .font(.mainTextSemiBold24)
                    Text("님")
                        .foregroundStyle(Color("black02"))
                        .font(.mainTextSemiBold24)
                }
                Text("환영합니다! 🙌🏻")
                    .foregroundStyle(Color("black02"))
                    .font(.mainTextSemiBold24)
            }
            
            HStack(spacing: 10.5) {
                InfoButton(icon: Image("star"), title: "별 히스토리", action: {print("별 히스토리")})
                InfoButton(icon: Image("receipt"), title: "전자영수증", action: {router.push(.receipts)})
                InfoButton(icon: Image("myCup"), title: "나만의 메뉴", action: {print("나만의 메뉴")})
            }
            .padding(.top, 24)
        }
    }
    
    private var payView: some View {
        VStack(alignment: .leading) {
            Text("Pay")
                .font(.mainTextSemiBold18)
                .padding(.bottom, 8)
            
            HStack {
                listItem(icon: Image("card"), title: "스타벅스 카드 등록")
                
                Spacer()
                
                listItem(icon: Image("card_change"), title: "카드 교환권 등록")
            }
            .padding(.vertical, 16)
            
            HStack {
                listItem(icon: Image("coupon"), title: "쿠폰 등록")
                
                Spacer()
                
                listItem(icon: Image("coupon_history"), title: "쿠폰 히스토리")
            }
            .padding(.vertical, 16)
        }
        .overlay(alignment: .bottom) {
            Divider()
                .background(Color.black.opacity(0.12))
        }
        .padding(.horizontal, 10)
    }
    
    private var supportView: some View {
        VStack(alignment: .leading) {
            Text("고객지원")
                .font(.mainTextSemiBold18)
            
            HStack {
                listItem(icon: Image("store_care"), title: "스토어 케어")
                
                Spacer()
                
                listItem(icon:Image("customer"), title: "고객의 소리")
            }
            .padding(.vertical, 16)
            
            HStack {
                listItem(icon: Image("store_info"), title: "매장 정보")
                
                Spacer()
                
                listItem(icon: Image("return_info"), title: "반납기 정보")
            }
            .padding(.vertical, 16)
            
            HStack {
                listItem(icon: Image("my_review"), title: "마이 스타벅스 리뷰")
                
                Spacer()
            }
            .padding(.vertical, 16)
        }
        .padding(.horizontal, 10)
    }
    
    struct InfoButton: View {
        let icon: Image
        let title: String
        private var action: () -> Void
        
        init(icon: Image, title: String, action: @escaping () -> Void) {
            self.icon = icon
            self.title = title
            self.action = action
        }

        var body: some View {
            Button(action: {
                action()
            }, label: {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .frame(width: 102, height: 108)
                    .shadow(radius: 2, x: 0, y: 0)
                    .overlay(content: {
                        VStack(spacing: 4) {
                            icon
                                .resizable()
                                .frame(width: 48, height: 48)
                                .foregroundStyle(Color("green01"))
                            
                            Text(title)
                                .font(.mainTextSemiBold16)
                                .foregroundStyle(Color("black03"))
                        }
                    })
            })
        }
    }
    
    struct listItem: View {
        let icon: Image
        let title: String
        
        init(icon: Image, title: String) {
            self.icon = icon
            self.title = title
        }
        
        var body: some View {
            Button(action: {
                print(title)
            }, label: {
                HStack(spacing: 6) {
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 26, maxHeight: 26)
                    Text(title)
                        .font(.mainTextSemiBold16)
                    
                    Spacer()
                }
                .foregroundStyle(.black)
            })
            .frame(width: 180, height: 32)
        }
    }
    
}

#Preview {
    OtherView()
}
