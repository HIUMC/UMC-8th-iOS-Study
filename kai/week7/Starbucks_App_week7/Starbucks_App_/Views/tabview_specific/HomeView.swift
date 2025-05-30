//
//  HomeView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/27/25.
//

import SwiftUI

struct HomeView: View {
    // 광고팝업
    @State private var showAd = false

    // 네비게이션
    @State private var path = NavigationPath()

    // 뷰모델
    @State var homescrolleViewModel = HomeScrollViewModel() // 커피, 디저트에 대한 정보
    @State var whatsnewViewModel = WhatsNewViewModel()

    // 게이지바 별 개수
    @State var currentStar: Int = 1

    @AppStorage("userName") private var userName: String?

    var body: some View {
        ScrollView(.vertical) {
            TopView()
            RecommendView()
            MiddleView()
            WhatsNewView()
            BottomView1()
            DesertView()
            BottomView2()
        }
        .onAppear {
            showAd = true
        }
        .fullScreenCover(isPresented: $showAd) {
            AdvertisementView(showAd: $showAd)
        }
    }
}

// 상단 게이지바 뷰
struct TopView: View {
    var body: some View {
        ZStack {
            Image(.topImg)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 5) {
                Text("골든 미모사 그린 티와 함께 \n행복한 새해의 축배를 들어요!")
                    .font(.PretendardRegular24)

                Text("11 ⭑ until next Reward")
                    .font(.PretendardSemiBold16)
                    .foregroundStyle(.gaugebar)
                    .frame(height: 10)
            }
        }
        // 상단토끼뷰에는 옆에 여백이 없어서 따로 빼주었다
        Spacer()
            .frame(height: 23)
        Image(.advertisebanner)
            .resizable()
            .scaledToFit()
    }
}

// 추천 메뉴 뷰
struct RecommendView: View {
    var viewModel: HomeScrollViewModel = HomeScrollViewModel()

    @AppStorage("nickname") private var nickname: String = "(설정 닉네임)"

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(nickname)")
                    .font(.PretendardRegular24)
                    .foregroundStyle(Color.gaugebar)
                Text("님을 위한 추천 메뉴")
                    .font(.PretendardRegular24)
                    .foregroundColor(.black)
            }
            .padding(.leading, 20)

            Spacer().frame(height: 25)
                .padding(.horizontal, 16)

            ScrollView(.horizontal) {
                LazyHStack(spacing: 15) {
                    ForEach(Array(viewModel.coffeeCard.enumerated()), id: \.element) { index, coffee in
                        CircleImageCard(imageName: coffee.imageName, title: coffee.title)
                        
                    }
                }
            }
        }
    }
}

// 중간 이벤트 배너 뷰
struct MiddleView: View {
    var body: some View {
        VStack {
            Image(.eventBanner)
                .resizable()
                .scaledToFit()
            Image(.serviceSuscibe)
                .resizable()
                .scaledToFit()
        }
        .padding(.horizontal, 10)
    }
}

// 디저트 뷰
struct DesertView: View {
    var viewModel: HomeScrollViewModel = HomeScrollViewModel()

    var body: some View {
        HStack {
            Spacer()
                .frame(width: 10)

            Text("하루가 달콤해지는 디저트")
                .font(.PretendardRegular24)
                .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal, 5)
        
        ScrollView(.horizontal) {
            LazyHStack(spacing: 15) {
                ForEach(Array(viewModel.desertCard.enumerated()), id: \.element) { index, desert in
                    CircleImageCard(imageName: desert.imageName, title: desert.title)
                }
            }
        }

    
    }
}

// What's New 뷰
struct WhatsNewView: View {
    var viewModel: WhatsNewViewModel = WhatsNewViewModel()

    var body: some View {
        HStack {
            Spacer()
                .frame(width: 10)

            Text("What's New")
                .font(.PretendardRegular24)
                .foregroundColor(.black)
            Spacer()
        }
        .padding(.horizontal, 5)

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(viewModel.items) { item in
                    VStack {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 242, height: 160)

                        Spacer()
                            .frame(height: 10)

                        Text(item.title)
                            .font(.PretendardRegular18)

                        Spacer()
                            .frame(height: 10)

                        Text(item.description)
                            .font(.PretendardRegular13)
                            .foregroundStyle(Color.gray)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                    }
                }
            }
        }
    }
}

struct BottomView1: View {
    var body: some View {
        VStack {
            Image(.mugbanner)
                .resizable()
                .scaledToFit()

            Image(.starbanner)
                .resizable()
                .scaledToFit()

            Image(.deliverybanner)
                .resizable()
                .scaledToFit()
        }
        .padding(.horizontal, 5) // 패딩
    }
}

struct BottomView2: View {
    var body: some View {
        VStack {
            Image(.coldbrewbanner)
                .resizable()
                .scaledToFit()

            Image(.baristafavorite)
                .resizable()
                .scaledToFit()
        }
        .padding(.horizontal, 5)
    }
}

#Preview {
    HomeView()
}
