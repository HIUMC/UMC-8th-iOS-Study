//
//  HomeView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/1/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack (spacing: 20) {
                topBanner
                Image(.homeAd)
                recommand
                Image(.homeEvent)
                Image(.homeService)
                new
                banners
            }
        }
        .ignoresSafeArea()
        .foregroundStyle(Color("white00"))
    }
    
    private var topBanner: some View {
        VStack {
            ZStack(alignment: .leading) {
                Image(.homeTop)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 226)
                
                HStack(spacing: 4) {
                    Spacer()
                    Text("내용 보기")
                        .font(.mainTextRegular13)
                    Image(systemName: "arrow.right")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 12, height: 12)
                }
                .foregroundStyle(Color("gray06"))
                .padding(.top, 200)
                .padding(.trailing, 24)
                
                VStack(alignment: .leading, spacing: 34) {
                    Text("골든 미모사 그린 티와 함께\n행복한 새해의 축배를 들어요!")
                        .font(.mainTextBold24)
                        .foregroundColor(Color("black03"))
                        .lineSpacing(1.5)
                }
                .padding(.top, 100)
                .padding(.leading, 28)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text("11★ until next Reward")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(Color("brown02"))
                    ProgressView(value: 1, total: 12)
                        .frame(width: 256)
                        .tint(Color("brown02"))
                }
                
                Spacer()
                
                HStack(spacing: 5) {
                    Text("1")
                        .font(.mainTextSemiBold38)
                        .foregroundStyle(Color("black03"))
                    Text("/")
                        .font(.mainTextMedium24)
                        .foregroundStyle(Color("gray00"))
                    Text("12★")
                        .font(.mainTextSemiBold24)
                        .foregroundStyle(Color("brown02"))
                }
            }
            .padding(.leading, 28)
            .padding(.trailing, 40)
            .frame(height: 33)
        }
    }
    
    @AppStorage("nickname") private var nickname
    : String?
    private var recommand: some View {
        VStack(alignment: .leading, spacing: 25) {
            Group {
                Text("(\(nickname ?? "설정 닉네임"))")
                    .foregroundStyle(Color("brown01"))
                + Text("님을 위한 추천 메뉴")
                    .foregroundStyle(Color("black03"))
            }
            .font(.mainTextMedium24)
            .padding(.leading, 10)
                
            ScrollView(.horizontal) {
                LazyHGrid(rows: Array(repeating: GridItem(.fixed(130), spacing: 16), count: 1), content: {
                    ForEach(CoffeeModel.allCases, id: \.self, content: {
                        coffee in coffeeCard(coffee)
                    })
                })
            }
            .padding(.horizontal, 10)
        }
    }
    
    private func coffeeCard(_ model: CoffeeModel) -> some View {
        VStack(spacing: 10) {
            Image(model.returnCoffeeImg())
                .resizable()
                .frame(width: 130, height: 130)
            
            Text(model.returnCoffeeName())
                .font(.mainTextSemiBold14)
                .foregroundStyle(Color("black02"))
        }
    }
    
    private var new: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What's new")
                .foregroundStyle(Color("black03"))
                .font(.mainTextMedium24)
                .padding(.leading, 10)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: Array(repeating: GridItem(.fixed(160), spacing: 16), count: 1), content: {
                    ForEach(WhatsNewModel.allCases, id: \.self, content: {
                        new in newCard(new)
                    })
                })
            }
            .padding(.horizontal, 10)
        }
    }
    
    private func newCard(_ model: WhatsNewModel) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(model.returnNewImg())
                .resizable()
                .frame(width: 242, height: 160)
            
            VStack(alignment: .leading, spacing: 9) {
                Text(model.returnNewName())
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(Color("black02"))
                
                Text(model.returnNewDetail())
                    .font(.mainTextSemiBold13)
                    .foregroundStyle(Color("gray03"))
            }
        }
        .frame(width: 242)
    }
    
    private var banners: some View {
        VStack(spacing: 14) {
            Image(.homeBanner01)
            Image(.homeBanner02)
            Image(.homeBanner03)
        }
    }
}

#Preview {
    HomeView()
}
