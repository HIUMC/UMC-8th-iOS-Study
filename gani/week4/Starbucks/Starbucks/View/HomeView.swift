//
//  HomeView.swift
//  Starbucks
//
//  Created by 이가원 on 4/3/25.
//
import SwiftUI
import Foundation

struct HomeView: View {
    @AppStorage("Nickname") var nickname: String = ""
    @StateObject private var RecviewModel = RecommendedMenuViewModel()
    @StateObject private var WhatsNewModel = WhatsNewViewModel()
    @StateObject private var DesertModel = DesertMenuViewModel()
    @State private var showAddView = true

    var body: some View {
        ScrollView {
            VStack {
                topBanner1
                topBanner2
                Spacer().frame(height: 23)
                Image(.banner)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                Spacer().frame(height: 20)
                RecommendedMenu
                Spacer().frame(height: 20)
                Image(.eventBanner)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                Spacer().frame(height: 20)
                Image(.serviceSuscibe)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                Spacer().frame(height: 20)
                WhatsNew
                Spacer().frame(height: 20)
                Banners
                Spacer().frame(height: 20)
                DesertMenu
                Spacer().frame(height: 20)
                Banners2
                Spacer().frame(height:71)
            }
        }
        .ignoresSafeArea()
                .sheet(isPresented: $showAddView) {
                    AddView()
                }
                .onAppear {
                    showAddView = true
                }
    }

    private var topBanner1: some View {
        ZStack {
            Image(.topImg)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)

            VStack {
                Text("골든 미모사 그린티와 함께 \n행복한 새해의 축배를 들어요!")
                    .font(.custom("Pretendard-Bold", size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 120)
                    .padding(.leading, 28.16)

                HStack {
                    Text(" ")
                        .font(.custom("Pretendard-Regular", size: 13))
                        .foregroundStyle(.gray6)
                        .padding(.leading, 350.37)
                    Spacer().frame(width: 4)
                    Image(.goLine)
                    Spacer().frame(width: 21)
                }
            }
        }
    }

    private var topBanner2: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text("11★ until next Reward")
                    .foregroundColor(Color("brown02"))
                    .font(.custom("Pretendard-SemiBold", size: 16))

                GaugeBar(current: 1, total: 12)
                    .frame(maxWidth: .infinity, maxHeight: 8)
            }

            Spacer()

            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text("1")
                    .font(.custom("Pretendard-SemiBold", size: 38))
                Text("/")
                    .font(.custom("Pretendard-SemiBold", size: 24))
                    .foregroundColor(Color("gray0"))
                Text("12")
                    .font(.custom("Pretendard-SemiBold", size: 24))
                    .foregroundColor(Color("brown01"))
                Text("★")
                    .font(.custom("Pretendard-SemiBold", size: 14))
                    .foregroundColor(Color("brown01"))
            }
            .padding(.trailing, 16)
        }
        .padding(.horizontal, 20)
    }

    private var RecommendedMenu: some View {
        VStack(alignment: .leading) {
            Text("님을 위한 추천 메뉴")
                .font(.custom("Pretendard-Bold", size: 24))
                .foregroundColor(Color("brown01"))
                .padding(.bottom, 25)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(RecviewModel.menus) { menu in
                        CircleImageCard(imageName: menu.imageName, name: menu.name)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var WhatsNew: some View {
        VStack(alignment: .leading) {
            Text("What's New")
                .font(.custom("Pretendard-Bold", size: 24))
                .padding(.bottom, 10)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(WhatsNewModel.whatsnews) { WhatsNew in
                        AddCard(imageName: WhatsNew.imageName, title: WhatsNew.title, text: WhatsNew.text)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var Banners: some View {
        VStack(spacing: 14) {
            Image(.mugcup)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image(.onlinebanner)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image(.delivery)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding(.horizontal)
    }

    private var DesertMenu: some View {
        VStack(alignment: .leading) {
            Text("하루가 달콤해지는 디저트")
                .font(.custom("Pretendard-Bold", size: 24))
                .padding(.bottom, 25)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(DesertModel.desertmenus) { desert in
                        CircleImageCard(imageName: desert.imageName, name: desert.name)
                    }
                }
                .padding(.horizontal)
            }
        }
    }

    private var Banners2: some View {
        VStack(spacing: 14) {
            Image(.coldbrewBanner)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image(.drinkBanner)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Image(.starbucksBanner)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .padding(.horizontal)
    }

    struct GaugeBar: View {
        let current: Int
        let total: Int

        var body: some View {
            let ratio = CGFloat(current) / CGFloat(total)

            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 8)

                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.brown01)
                    .frame(width: 255.78667 * ratio, height: 8)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}

#Preview {
    HomeView()
}
