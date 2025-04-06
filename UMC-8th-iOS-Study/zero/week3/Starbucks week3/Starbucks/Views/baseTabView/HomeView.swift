//
//  HomeView.swift
//  Starbucks
//
//  Created by 김영택 on 3/29/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var progress: CGFloat = 0.1
    
    @AppStorage("newID") private var nickname: String = ""
    
    var body: some View {
        
        ScrollView(.vertical) {
            
            VStack(spacing:20){
                
                topView
                
                BearView
                
                RecommendView
                
                CircleImageCardView()
                
                Image(.eventBanner)
                
                Image(.serviceSuscibe)
                
                WhatView()
                
                SetView
                
                BreadImageView()
                
                BottomView
                    
            }
        }
    }
    
    private var topView: some View{
        
        ZStack{
            Image(.topImg)
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .leading){
                Spacer().frame(height:106)
                
                Text("골든 미모사 그린 티와 함께 행복한 새해의 축배를 들어요!")
                    .font(.PretendardSemibold24)
                    .frame(maxWidth:312, alignment: .topLeading)
                Spacer().frame(height: 9)
                
                HStack{
                    Text("내용 보기")
                        .font(.PretendardRegular13)
                        .foregroundStyle(.seecontent)
                        .padding(.leading, 300)
                    Spacer().frame(width:4)
                    Image(.right)
                }//HStack End
                Spacer().frame(height:2)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("11★ until next Reward")
                            .font(.PretendardSemibold16)
                            .foregroundStyle(.reward)
                        
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 255, height: 8)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.progress)
                                .frame(width: 255 * progress, height: 8) //
                                .animation(.easeInOut(duration: 0.3), value: progress)
                        }//ZStack End
                    }//VStack End
                    .frame(width: 255)
                    
                    Spacer().frame(width:24)
                    Text("1")
                        .font(.PretendardSemibold38)
                    Spacer().frame(width:5)
                    Text("/")
                        .font(.PretendardLight24)
                        .foregroundStyle(.gray)
                    Spacer().frame(width:5)
                    Text("12★")
                        .font(.PretendardSemibold24)
                        .foregroundStyle(.reward)
                    
                    
                }
            }
        }
    }
    
    private var BearView: some View {
        ZStack{
            Image(.bearBanner)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 420, height: 183)
                .clipped()
                .cornerRadius(4)
                .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 6)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
            VStack(alignment: .leading){
                Text("아이스 챌린지 카페 아메리카노")
                    .font(.PretendardExtrabold24)
                    .foregroundStyle(.progress)
                Spacer().frame(height:3)
                Text("주문하고,")
                    .font(.PretendardExtrabold24)
                    .foregroundStyle(.white)
                Spacer().frame(height:3)
                Text("사이즈 업 ")
                    .font(.PretendardExtrabold24)
                    .foregroundStyle(.progress)
                + Text("받으세요!")
                    .font(.PretendardExtrabold24)
                    .foregroundStyle(.white)
                
                Spacer().frame(height:13)
                
                Text("22023.1.26~1.30")
                    .font(.PretendarMedium16)
                    .foregroundStyle(.white)
                
            }.padding(.trailing, 85)
        }
    }
    private var RecommendView: some View {
        HStack{
            Text("\(nickname.isEmpty ? "(설정 닉네임)" : nickname)")
                .foregroundStyle(.login)
                .font(.PretendardRegular24)
            Text("님을 위한 추천 메뉴")
                .foregroundStyle(.black)
                .font(.PretendardRegular24)
        }.padding(.trailing, 55)
    }
    private var SetView: some View {
        VStack{
            Image(.mugbanner)
            
            Spacer().frame(height:3)
            
            ZStack(alignment: .topLeading){
                Image(.starbanner)
                
                VStack(alignment: .leading){
                    Text("TIP")
                        .font(.PretendardSemibold13)
                        .foregroundStyle(.gray)
                    Spacer().frame(height:4)
                    
                    Text("온라인 스토어\n별★ 적립 혜택")
                        .font(.PretendardBold24)
                    Spacer().frame(height:16)
                    
                    Text("온라인 스토어 구매 시\n별★을 적립해 드립니다.")
                        .font(.PretendardSemibold16)
                        .foregroundStyle(.gray)
                }.padding(.leading, 30)
                    .padding(.top, 70)
            }
            Spacer().frame(height:4)
            
            ZStack(alignment: .topLeading){
                Image(.deliverybanner)
                
                VStack(alignment: .leading){
                    Text("딜리버리\n예약 배달 서비스")
                        .font(.PretendardBold22)
                        .foregroundStyle(.delivery)
                    Spacer().frame(height:16)
                    
                    Text("특별한 순간을 위해\n미리 예약해 보세요.")
                        .font(.PretendardSemibold16)
                }.padding(.leading, 36)
                    .padding(.top, 55)
            }
        }
    }
    private var BottomView: some View {
        VStack{
            Image(.coldbrewbanner)
            
            Spacer().frame(height:3)
            
            Image(.baristafavorite)
            
            Spacer().frame(height:3)
            
            Image(.sizeupbanner)
        }
    }
}

    


#Preview {
    HomeView()
}
