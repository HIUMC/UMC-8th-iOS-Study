//
//  HomeView.swift
//  Starbucks
//
//  Created by nau on 3/26/25.
//

import SwiftUI
import Foundation

struct HomeView: View {
    
    @Environment(NavigationRouter.self) var router
    
    @State var viewModel: HomeViewModel = .init()
    
    @State var currentStar : Int = 1
    
    @AppStorage("nickname") var nickname = ""
    
    //계산된 비율
    var starRatio: Double {
        Double(currentStar) / 12.0
    }
    
    var body: some View {
        
        ScrollView {
            ZStack(alignment: .top) {
                GeometryReader { geo in
                    let y = geo.frame(in: .global).minY
                    let opacity = max(0 , min(1, 1 + (y / 150 )))
                    
                    Image(.topImg)
                        .opacity(opacity)
                }
                
                VStack(alignment: .center, spacing: 20) {
                    Spacer().frame(height: 90)
                    
                    topView
                    
                    Image(.homeBanner)
                        .resizable()
                        .scaledToFit()
                    
                    recommendMenuView
                    
                    Image(.eventBanner)
                        .resizable()
                        .scaledToFit()
                    
                    Image(.serviceSuscibe)
                        .resizable()
                        .scaledToFit()
                    
                    whatsNewView
                    
                    adView1
                    
                    desertView
                    
                    adView2
                    
                }.padding(.horizontal, 10)
            }
        }.ignoresSafeArea()
    }
    
    private var topView: some View {
        VStack(alignment: .leading) {
            
            Text("골든 미모사 그린 티와 함께\n행복한 새해의 축배를 들어요!")
                .font(.mainTextBold24)
                .foregroundStyle(.black03)
                .offset(y: 15)
            
            Spacer().frame(maxHeight: 25)
            
            HStack {
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("내용 보기")
                            .kerning(-1)
                            .font(.mainTextRegular13)
                            .foregroundStyle(.gray06)
                        
                        Image(.goLine)
                    }
                })
            }
            .frame(maxWidth: 330)
            .offset(x : 15 ,y: 15)
            
            gaugeView
            
        }
        .ignoresSafeArea()
        .frame(maxWidth: 380)
    }
    
    private var gaugeView: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(12 - currentStar)★ until next Reward")
                    .font(.mainTextSemibold16)
                    .foregroundStyle(.brown01)
                
                
                //gauge height, 배경 컬러 설정 어케 하는거지?
                Gauge(value: starRatio) {}
                    .gaugeStyle(.accessoryLinearCapacity)
                    .tint(.brown01)
                    .frame(maxWidth: UIScreen.screenSize.width / 1.7)
            }
            
            Spacer().frame(maxWidth: 36)
            
            HStack {
                Text("\(currentStar)")
                    .font(.mainTextSemibold38)
                    .foregroundStyle(.black03)
                Text("/")
                    .foregroundStyle(.gray07)
                Text("12")
                    .font(.mainTextSemibold24)
                    .foregroundStyle(.brown02)
                Text("★")
                    .font(.mainTextSemibold14)
                    .foregroundStyle(.brown02)
                    .offset(x: -7, y: 4)
            }
        }
    }
    
    private var recommendMenuView : some View {
        VStack(alignment: .leading) {
            HStack {
                Group {
                    Text(nickname == "" ? "(설정 닉네임)" : "\(nickname)"  ).foregroundStyle(.brown01)
                    Text("님을 위한 추천 메뉴")
                        .offset(x: -6)
                }.font(.mainTextBold24)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.recommendMenuModel1, id: \.id) { model in
                        if let detail = findDetailMenu(for: model) {
                            Button {
                                router.push(.detail(detail))
                            } label: {
                                circleImageCard(model)
                            }
                        } else {
                            // fallback UI (optional)
                            circleImageCard(model)
                                .overlay(
                                    Text("상세 정보 없음")
                                        .font(.caption)
                                        .foregroundColor(.red)
                                        .padding(4),
                                    alignment: .bottom
                                )
                        }
                    }
                }
            }
            .padding(.leading, 10)
            .frame(maxHeight: 160)
        }
    }
    
    
    private func circleImageCard(_ model: RecommendMenuModel) -> some View {
        VStack {
            Image(model.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 130, maxHeight: 130)
            
            Spacer().frame(height: 10)
            
            Text(model.name)
                .font(.mainTextSemibold14)
                .foregroundStyle(.black02)
        }
    }
    
    private var whatsNewView : some View {
        VStack(alignment: .leading) {
            Text("What's New")
                .font(.mainTextBold24)
                .foregroundStyle(.black03)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.newsModel, id: \.id){ model in
                        newsCard(model)
                    }
                }
            }
        }.frame(maxHeight: 295)
    }
    
    private func newsCard(_ model: NewsModel) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            Image(model.image)
                .resizable()
                .scaledToFit()
                .frame(width: 242, height: 160)
            
            Text(model.title)
                .font(.mainTextSemiBold18)
                .foregroundStyle(.black02)
                .lineLimit(1)
            
            Text(model.description)
                .font(.mainTextSemibold13)
                .foregroundStyle(.gray03)
                .lineLimit(2)
            
        }.frame(width: 240, height: 249)
    }
    
    private var adView1: some View {
        VStack {
            Group {
                Image(.homeAd1)
                    .resizable()
                Image(.homeAd2)
                    .resizable()
                Image(.homeAd3)
                    .resizable()
            }
            .frame(width: UIScreen.main.bounds.width - 20)
            .scaledToFit()
        }
    }
    
    private var desertView: some View {
        VStack(alignment: .leading) {
            Text("하루가 달콤해지는 디저트")
                .font(.mainTextBold24)
                .foregroundStyle(.black03)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.recommendMenuModel2, id: \.id) { model in
                        circleImageCard(model)
                    }
                }
            }
        }
        .padding(.leading, 10)
        .frame(maxHeight: 220)
    }
    
    private var adView2: some View {
        VStack {
            Group {
                Image(.homeAd4)
                    .resizable()
                Image(.homeAd5)
                    .resizable()
                Image(.homeAd6)
                    .resizable()
            }
            .frame(width: UIScreen.main.bounds.width - 20)
            .scaledToFit()
        }
    }
    
    private func findDetailMenu(for menu: RecommendMenuModel) -> DetailMenuModel? {
        return viewModel.detailMenuModel.first { $0.menuName == menu.name }
    }
}
                            

#Preview {
    HomeView()
}
