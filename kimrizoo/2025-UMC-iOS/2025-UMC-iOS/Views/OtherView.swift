//
//  OtherView.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 3/27/25.
//

import SwiftUI

struct OtherView: View {
    
    @AppStorage("nickname") private var storedNickname: String = ""
    
    var body: some View {
        VStack{

            /// 상단
            HStack{
                Text("Other")
                    .font(.customPretend(.bold, size: 24))
                
                Spacer()
                
                Button(action: {
                    print("로그아웃")
                }) {
                    Image("Logout")
                }
            } // HStack 끝
            .padding(.horizontal, 23.5)
            
            Spacer().frame(height: 16)
            
            // 중간
            VStack {
                
                Spacer().frame(height: 41)
                
                VStack{
                    VStack {
                        HStack {
                            Text("\(storedNickname.isEmpty ? "(작성한 닉네임)" : storedNickname)")
                                .foregroundStyle(Color.mainGreen)
                                .font(.customPretend(.semiBold, size: 24))
                            
                            Text("님")
                                .font(.customPretend(.semiBold, size: 24))
                        }
                        
                        HStack{
                            Text("환영합니다!")
                                .font(.customPretend(.semiBold, size: 24))
                            Image("Hand")
                        }
                        
                        Spacer().frame(height: 24)
                        
                        HStack(spacing: 10.5) {
                            MenuItemView(imageName: "Star", title: "별 히스토리") {
                                print("⭐️ 별 히스토리 버튼 클릭됨!")
                            }
                            MenuItemView(imageName: "Receipt", title: "전자영수증") {
                                print("📄 전자영수증 버튼 클릭됨!")
                            }
                            MenuItemView(imageName: "My", title: "나만의 메뉴") {
                                print("☕ 나만의 메뉴 버튼 클릭됨!")
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                    }
                    
                    Spacer()
                    
                    // Pay Section
                    VStack {
                        HStack{
                            Text("Pay")
                                .font(.customPretend(.semiBold, size: 18))
                            
                            Spacer()
                        }
                        
                        VStack {
                            HStack {
                                FeatureItemView(imageName: "card", text: "스타벅스 카드 등록") {
                                            print("💳 스타벅스 카드 등록 버튼 클릭됨!")
                                        }
                                
                                Spacer()
                                
                                FeatureItemView(imageName: "card", text: "카드 교환권 등록") {
                                            print("💳 카드 교환권 등록 버튼 클릭됨!")
                                        }
                            }
                            
                            HStack{
                                FeatureItemView(imageName: "conpon", text: "쿠폰 등록") {
                                            print("💳 쿠폰 등록 버튼 클릭됨!")
                                        }
                                
                                Spacer()
                                
                                FeatureItemView(imageName: "conpon_history", text: "쿠폰 히스토리") {
                                            print("💳 쿠폰 히스토리 버튼 클릭됨!")
                                        }
                            }
                            
                            Divider()
                        }
                    }
                    .padding(.horizontal, 10)
                    // Pay Section End
                    
                    Spacer()
                    // 고객지원 Section
                    VStack(alignment: .leading) {
                        HStack{
                            Text("고객지원")
                                .font(.customPretend(.semiBold, size: 18))
                            
                            Spacer()
                        }
                        
                        VStack{
                            HStack {
                                FeatureItemView(imageName: "store", text: "스토어 케어") {
                                            print("💳 스토어 케어 버튼 클릭됨!")
                                        }
                                
                                Spacer()
                                
                                FeatureItemView(imageName: "customer", text: "고객의 소리") {
                                            print("💳 고객의 소리 버튼 클릭됨!")
                                        }
                            }
                            
                            HStack{
                                FeatureItemView(imageName: "location", text: "매장 정보") {
                                            print("💳 매장 정보 버튼 클릭됨!")
                                        }
                                
                                Spacer()
                                
                                FeatureItemView(imageName: "return_info", text: "반납기 정보") {
                                            print("💳 반납기 정보 버튼 클릭됨!")
                                        }
                            }
                            
                            HStack{
                                FeatureItemView(imageName: "my_review", text: "마이 스타벅스 리뷰") {
                                            print("💳 마이 스타벅스 리뷰 버튼 클릭됨!")
                                        }
                                
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal, 10)
                    // 고객지원 Section End
                    
                }
                
                Spacer().frame(height: 41)
            }
            .background(Color.otherBackground)
            // 중간 끝
            
            //하단
            BottomTapView()
        }
    }
}

struct MenuItemView: View {
    let imageName: String
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)

                Text(title)
                    .font(.customPretend(.semiBold, size: 16))
                    .foregroundColor(.black)
            }
            .frame(width: 102, height: 108)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white))
            .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 2, y: 2)
        }
    }
}

struct FeatureItemView: View {
    let imageName: String
    let text: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack{
                Image(imageName)
                    
                
                Spacer().frame(width: 4)
                
                Text(text)
                    .font(.customPretend(.semiBold, size: 16))
                    .foregroundStyle(Color.otherBlack)
            }
            .padding(.vertical, 16)
            .frame(width: 157, alignment: .leading)
        }
    }
}

#Preview {
    OtherView()
}
