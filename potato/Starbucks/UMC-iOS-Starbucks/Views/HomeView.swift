//
//  HomeView.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/1/25.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel: HomeViewModel = .init()
    
    // 네비게이션 할지말지 결정하는 변수
    @State private var navigationTrue: Bool = false
    
    var body: some View {
            ScrollView {
                VStack (spacing: 20) {
                    topBanner
                    Image(.homeAd)
                    recommand
                    Image(.homeEvent)
                    Image(.homeService)
                    new
                    banners01
                    desert
                    banners02
                }
            }
            .toolbarVisibility(.hidden)
            .ignoresSafeArea()
            .foregroundStyle(Color("white00"))
            .navigationDestination(isPresented: $navigationTrue, destination: {
                CoffeeDetailView(viewModel: viewModel)
            })
    }
    
    private var star: Int = 1
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
                    Text("\(12 - star)★ until next Reward")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(Color("brown02"))
                    ProgressView(value: 1, total: 12)
                        .frame(width: 256)
                        .tint(Color("brown02"))
                }
                
                Spacer()
                
                HStack(spacing: 5) {
                    Text("\(star)")
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
                    ForEach(viewModel.coffees) {
                        coffee in foodCard(img: coffee.img, name: coffee.name)
                            .onTapGesture {
                                // 선택한 커피 정보 넘기기
                                // viewModel.selectedCoffee = coffee
                                 if let detailCoffee = CoffeeDetailModel.from(coffee: coffee) {
                                 viewModel.selectedCoffee = detailCoffee
                                 }
                                 self.navigationTrue.toggle()
                            }
                    }
                })
            }
            .padding(.horizontal, 10)
        }
    }
    
    private var desert: some View {
        VStack(alignment: .leading, spacing: 25) {
            Text("하루를 달콤하게 할 디저트")
                .foregroundStyle(Color("black03"))
                .font(.mainTextMedium24)
                .padding(.leading, 10)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: Array(repeating: GridItem(.fixed(130), spacing: 16), count: 1), content: {
                    ForEach(viewModel.deserts) {
                        desert in foodCard(img: desert.img, name: desert.name)
                    }
                })
            }
            .padding(.horizontal, 10)
        }
    }
    
    private func foodCard(img: String, name: String) -> some View {
        VStack(spacing: 10) {
            Image(img)
                .resizable()
                .frame(width: 130, height: 130)
            
            Text(name)
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
                    ForEach(viewModel.whatsNews) {
                        whatsnew in newCard(img: whatsnew.img, title: whatsnew.title, detail: whatsnew.detail)
                    }
                })
            }
            .padding(.horizontal, 10)
        }
    }
    
    private func newCard(img: String, title: String, detail: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(img)
                .resizable()
                .frame(width: 242, height: 160)
            
            VStack(alignment: .leading, spacing: 9) {
                Text(title)
                    .font(.mainTextSemiBold18)
                    .foregroundStyle(Color("black02"))
                
                Text(detail)
                    .font(.mainTextSemiBold13)
                    .foregroundStyle(Color("gray03"))
            }
        }
        .frame(width: 242)
    }
    
    private var banners01: some View {
        VStack(spacing: 14) {
            Image(.homeBanner01)
            Image(.homeBanner02)
            Image(.homeBanner03)
        }
    }
    
    private var banners02: some View {
        VStack(spacing: 14) {
            Image(.homeBanner04)
            Image(.homeBanner05)
            Image(.homeBanner06)
        }
    }
}

#Preview {
    HomeView()
}
