//
//  HomeView.swift
//  Starbucks
//
//  Created by 박정환 on 3/31/25.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("nickname") private var nickname: String = "(작성한 닉네임)"
    @State private var router = NavigationRouter()
    @State private var popup = false
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 10) {
                topBanner
                Image("adbanner")
                recommendMenu
                Image("eventBanner")
                Image("serviceSuscibe")
                newMenu
                middleBanner
                dessertMenu
                bottomBanner
            }
        }
        .ignoresSafeArea()
        .onAppear {
            popup = true
        }
        .fullScreenCover(isPresented: $popup) {
            PopupView()
        }
    }
    
    //맨 위 배너
    private var topBanner: some View {
        ZStack(alignment: .center) {
            Image("top_img")
            VStack(alignment: .leading, spacing: 10) {
                Text("골든 미모사 그린 티와 함께\n행복한 새해의 축배를 들어요!")
                    
                    .font(.mainTextBold24)
                    .foregroundStyle(.black03)
                progressBar
            }
        }
        .frame(maxWidth: .infinity, minHeight: 259)
        .ignoresSafeArea(.all)
    }

    //게이지바
    private var progressBar: some View {
        HStack(alignment: .bottom) {
            ProgressView(value: 0.45) {
                Text("11★ until next Reward")
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(Color("brown02"))
            }
            .tint(.brown01)
            .presentationCornerRadius(4)
            .frame(width: 255, height: 35)
            .padding(.trailing, 36)
            //우측 하단
            VStack(spacing: 0) {
                //내용보기 버튼
                Button(action: {
                    print("내용 보기")
                }, label: {
                    HStack(alignment: .center, spacing: 4) {
                        Text("내용 보기")
                            .kerning(-0.5)
                            .foregroundStyle(.gray06)
                            .font(.mainTextRegular13)
                        Image("go_line")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 10, height: 10)
                    }
                })
                //리워드 숫자
                HStack(spacing: 5) {
                    Text("1")
                        .foregroundStyle(.black03)
                        .font(.pretendardBold(38))
                    Text("/")
                        .foregroundStyle(.gray)
                        .font(.pretendardLight(24))
                    HStack(alignment: .bottom, spacing: 0) {
                        Text("12")
                            .foregroundStyle(.brown02)
                            .font(.pretendardSemiBold(24))
                        Text("★")
                            .foregroundStyle(.brown02)
                            .font(.pretendardSemiBold(14))
                            .padding(.bottom, 2)
                    }
                }
            }
        }
    }
    
    //OOO님을 위한 추천 메뉴
    private var recommendMenu: some View {
        VStack {
            HStack {
                Group {
                    Text("\(nickname)님")
                        .foregroundStyle(.brown01)
                        .padding(.leading, 20)
                    Text("을 위한 추천 메뉴")
                        .foregroundStyle(.black03)
                }
                .font(.mainTextBold24)
                Spacer()
                
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(RecommendModel.dummy) { recommend in
                        VStack(spacing: 10) {
                            CircleImageCard(imageName: recommend.imageName)
                            
                            Text(recommend.title)
                                .font(.mainTextSemiBold14)
                                .foregroundColor(Color("black02"))
                        }
                        .onTapGesture {
                            router.push(.coffeeDetail)
                        }
                        .padding(.horizontal, 5)
                    }
                }
                .padding(.horizontal, 10)
            }
        }
    }
    
    private var newMenu: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("What’s New")
                .foregroundStyle(.black03)
                .font(.mainTextBold24)
                .padding(.leading, 20)
                
            ScrollView(.horizontal) {
                LazyHStack(spacing: 5) {
                    ForEach(NewModel.dummy, id: \.self) { new in
                        VStack(alignment: .leading, spacing: 10) {
                            Image(new.imageName)
                            Text(new.title)
                                .font(.mainTextSemiBold18)
                                .foregroundColor(Color("black02"))
                            
                            Text(new.content)
                                .font(.mainTextSemiBold13)
                                .foregroundColor(Color("gray03"))
                                .lineLimit(nil)  // 줄바꿈 허용
                        }
                    }.frame(maxWidth: 240)
                }
            }
        }
    }
    
    private var middleBanner: some View {
        VStack {
            Image("homemiddle1")
            Image("homemiddle2")
            Image("homemiddle3")
        }
    }
    
    private var dessertMenu: some View {
        VStack {
            HStack {
                Text("하루가 달콤해지는 디저트")
                    .foregroundStyle(.black03)
                    .font(.mainTextBold24)
                    .padding(.leading, 20)
                Spacer()
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 5) {
                    ForEach(DessertModel.dummy, id: \.self) { dessert in
                        VStack {
                            CircleImageCard(imageName: dessert.imageName)
                            
                            Text(dessert.title)
                                .font(.mainTextSemiBold14)
                                .foregroundColor(Color("black02"))
                        }
                    }
                }
            }
        }
    }

    private var bottomBanner: some View {
        VStack {
            Image("homebottom1")
            Image("homebottom2")
            Image("homebottom3")
        }
    }
}

#Preview {
    HomeView()
}
