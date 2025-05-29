//
//  OtherView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/27/25.
//

import SwiftUI

struct OtherView: View {
    
    @State private var nickname: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = true

    
    var body: some View {
        NavigationStack {
            VStack {
                // 상단 타이틀 + 로그아웃 버튼
                ZStack {
                    Text("Other")
                        .font(.mainTextBold24)
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            // ✅ 1. 로그인 상태 false로
                            isLoggedIn = false
                            
                            // ✅ 2. 키체인 삭제
                            KeychainService.shared.deleteToken()
                            KeychainService.shared.deleteNickname()
                            
                            print("로그아웃 완료")
                        }) {
                            Image("logout")
                        }

                    }
                }
                .padding(.top, 60)
                .padding(.horizontal, 20)
                .navigationBarHidden(true)
                
                Spacer().frame(height: 41)
                
                // 닉네임 표시
                VStack {
                    VStack(spacing: 0) {
                        Text(nickname.isEmpty ? "(작성한 닉네임)" : nickname + "님")
                            .foregroundColor(.green01)
                            .font(.mainTextSemiBold24)
                        
                        Text("환영합니다!")
                            .font(.mainTextSemiBold24)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                    
                    Spacer().frame(height: 24)
                    
                    HStack {
                        Button(action:{ print("별 히스토리") }) {
                            Image("starhistory")
                        }
                        
                        NavigationLink(destination: ReceiptView()) {
                            Image("receipt")
                        }
                        
                        Button(action:{ print("나만의 메뉴") }) {
                            Image("mymenu")
                        }
                        .foregroundStyle(.black)
                    }
                    .frame(width: 375, height: 108)
                    
                    Spacer().frame(height: 41)
                    
                    // Pay
                    VStack(alignment: .leading) {
                        Text("Pay")
                            .font(.PretendardBold18)
                            .foregroundStyle(.black)
                        
                        Spacer().frame(height: 8)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                MenuBtn(image: .starbuckscardregister, text: "스타벅스 카드 등록", action: { print("스타벅스 카드 등록") })
                                MenuBtn(image: .couponregister, text: "쿠폰 등록", action: { print("쿠폰 등록") })
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                MenuBtn(image: .cardexchangevoucher, text: "카드 교환권 등록", action: { print("카드 교환권 등록") })
                                MenuBtn(image: .couponhistory, text: "쿠폰 히스토리", action: { print("쿠폰 히스토리") })
                            }
                        }
                    }
                    .padding(.horizontal, 19)
                    
                    Spacer().frame(height: 41)
                    Divider()
                    Spacer().frame(height: 41)
                    
                    // 고객지원
                    VStack(alignment: .leading) {
                        Text("고객지원")
                            .font(.PretendardBold18)
                            .padding(.horizontal, 19)
                            .foregroundStyle(.black)
                        
                        Spacer().frame(height: 8)
                        
                        HStack {
                            VStack(alignment: .leading) {
                                MenuBtn(image: .storecare, text: "스토어 케어", action: { print("스토어 케어") })
                                
                                NavigationLink(destination: MapView(findLocationViewModel: FindLocationViewModel())) {
                                    MenuBtn(image: .storeinfo, text: "매장 정보", action: {})
                                }
                                
                                MenuBtn(image: .mystarbucksreview, text: "마이 스타벅스 리뷰", action: { print("마이 스타벅스 리뷰") })
                                Spacer()
                            }
                            Spacer()
                            VStack(alignment: .leading) {
                                MenuBtn(image: .customersound, text: "고객의 소리", action: { print("고객의 소리") })
                                MenuBtn(image: .returninfo, text: "반납기 정보", action: { print("반납기 정보") })
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 19)
                    }
                }
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                if let loaded = KeychainService.shared.loadNickname() {
                    nickname = loaded
                }
            }
        }
        
    }
    
}




struct MenuBtn: View {
    
    let image: ImageResource
    let text: String
    let action: () -> Void
    
    init(image: ImageResource, text: String, action: @escaping () -> Void) {
        self.image = image
        self.text = text
        self.action = action
    }
    
    var body: some View {
        
            HStack(spacing: 8) {
                Image(image)
                Text(text)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(.black02)
                
            }
        .background(Color.white)
    }
}

#Preview {
    OtherView()
}
