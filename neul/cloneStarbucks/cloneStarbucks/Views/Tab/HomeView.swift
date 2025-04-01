//
//  HomeView.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/31/25.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("nickname") private var nickname: String = "(작성한 닉네임)"
    @State private var router = NavigationRouter()
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 15) {
                topBanner
                Image(.home2)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                recommendMenu
                Image(.home4)
                Image(.home5)
                whatsNew
                banners
                dessertMenu
                events
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal, 8)
        .border(.red)
    }
    
    
    private var topBanner: some View {
        ZStack(alignment: .center) {
            Image(.home1)
                .border(.blue)
            VStack(alignment: .leading, spacing: 10) {
                Text("골든 미모사 그린 티와 함께\n행복한 새해의 축배를 들어요!")
                    .font(.MainTextBold24)
                    .foregroundStyle(.black03)
                    .padding(.top, 180)

                progressBar
            }
        }
        .frame(maxWidth: .infinity, minHeight: 259)
        .ignoresSafeArea(.all)
    }
    
    private var progressBar: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("11 ⭑ until next Reward")
                    .font(.MainTextSemiBold16)
                    .foregroundStyle(.brown01)
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // 배경 바
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(hex: "DBDBDB"))
                            .frame(height: 10)

                        // 채워진 부분
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.brown01)
                            .frame(width: geometry.size.width * (1 / 12), height: 10)
                            .animation(.easeInOut, value: 1)
                    }
                }
                .frame(width: 256, height: 8)
            }
            
            VStack(spacing: 5) {
                Button {
                    print("내용 보기")
                } label: {
                    Text("내용 보기")
                        .font(.MainTextRegular13)
                        .foregroundStyle(.gray06)
                }
                
                HStack(spacing: 5) {
                    Text("1")
                        .font(.MainTextSemiBold38)
                        .foregroundStyle(.black03)
                    Text("/")
                        .font(.MainTextLight14)
                        .foregroundStyle(Color(hex: "C9C9C9"))
                    Text("12 ⭑")
                        .font(.MainTextSemiBold24)
                        .foregroundStyle(.brown02)
                }

            }
        }
        
    }
    
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
                .font(.MainTextBold24)
                Spacer()
                
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(RecoMenuModel.dummy, id: \.self) { coffee in
                        makeCoffeeCard(coffee)
                            .onTapGesture {
                                //router.push(.coffeeDetail)
                            }
                    }
                }
            }
        }
    }
    
    private var whatsNew: some View {
        VStack {
            HStack {
                Image(.home6)
                    .padding(.leading, 20)
                Spacer()
            }
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 5) {
                    ForEach(WhatsNewModel.dummy, id: \.self) { new in
                        NewEventCard(imageName: new.imageName, title: new.title, content: new.content)
                    }
                }
            }
        }
    }
    
    private var banners: some View {
        VStack {
            Image(.home8)
            Image(.home9)
            Image(.home10)
        }
    }
    
    private var dessertMenu: some View {
        VStack {
            HStack {
                Text("하루가 달콤해지는 디저트")
                    .foregroundStyle(.black03)
                    .font(.MainTextBold24)
                    .padding(.leading, 20)
                Spacer()
                
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 5) {
                    ForEach(DessertModel.dummy, id: \.self) { dessert in
                        makeDessertCard(dessert)
                    }
                }
            }
        }
    }

    private var events: some View {
        VStack {
            Image(.home12)
            Image(.home13)
            Image(.home14)
        }
    }
    
    
    
    
    
    private func makeDessertCard(_ model: DessertModel) -> some View {
        VStack(spacing: 10) {
            Image(model.imageName)
                .resizable()
                .frame(width: 130, height: 130)
            Text(model.title)
                .font(.MainTextSemiBold14)
                .foregroundStyle(.black02)
        }
    }
    
    
        
    private func makeCoffeeCard(_ model: RecoMenuModel) -> some View {
        VStack(spacing: 10) {
            Image(model.imageName)
                .resizable()
                .frame(width: 130, height: 130)
            Text(model.title)
                .font(.MainTextSemiBold14)
                .foregroundStyle(.black02)
        }
    }
        

    
}

#Preview {
    HomeView()
}
