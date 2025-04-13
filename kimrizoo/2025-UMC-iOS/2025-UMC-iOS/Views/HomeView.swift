//
//  HomeView.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/3/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showAdvertisementSheet = true
    @State private var currentStars: Int = 4  // 현재 별 개수
    let totalStars: Int = 12  // 전체 별 개수

    var body: some View {
        VStack{
            ScrollView {
                VStack {
                    
                    // 상단 배너
                    ZStack {
                        VStack{
                            Spacer().frame(height: 14)
                            Image("top")
                                .resizable()
                                .scaledToFit()
                            Spacer().frame(height: 19)
                        }
                        
                        VStack {
                            // 타이틀 텍스트
                            Text("골든 미모사 그린 티와 함께\n행복한 새해의 축배를 들어요!")
                                .font(.system(size: 24))
                                .padding(.top, 106)
                                .padding(.trailing, 99)
                                .lineSpacing(6)
                            
                            // "내용 보기" 버튼
                            HStack {
                                Spacer()
                                Text("내용 보기")
                                    .foregroundStyle(Color.customGray2)
                                Image("go_line")
                                Spacer().frame(width: 10)
                            }
                            
                            // 게이지 바 & 숫자 표시
                            HStack{
                                VStack(alignment: .leading) {
                                    // 달성도 텍스트
                                    Text("\(totalStars - currentStars)★ until next Reward")
                                        .font(.customPretend(.bold, size: 16))
                                        .foregroundStyle(Color.brown2)
                                    
                                    // ProgressView로 게이지 바 구현
                                    ProgressView(value: Double(currentStars), total: Double(totalStars))
                                        .progressViewStyle(LinearProgressViewStyle(tint: .brown))
                                        .frame(width: 255, height: 8)
                                }
                                // VStack 끝
                                Spacer()
                                // 현재 진행도 숫자 표시
                                HStack {
                                    Text("\(currentStars)")
                                        .font(.title)
                                        .bold()
                                    Text("/")
                                    Text("\(totalStars)★")
                                        .foregroundColor(Color.brown2)
                                }
                            }
                        }
                        .padding(.horizontal, 29)
                    }
                    // 상단 배너 끝
                    
                    Spacer().frame(height: 23)
                    
                    // 곰돌이 배너
                    ZStack{
                        Image("banner")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 10)
                    }
                    // 곰돌이 배너 끝
                    
                    Spacer().frame(height: 20)
                    
                    // 추천 메뉴
                    RecommendMenuView()
                    //추천 메뉴 끝
                    
                    Spacer().frame(height: 20)
                    
                    // 이벤트 배너
                    Image("eventBanner")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 10)
                    
                    Spacer().frame(height: 20)
                    
                    Image("serviceSuscibe")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 10)
                    // 이벤트 배너 끝
                    
                    Spacer().frame(height: 20)
                    
                    // What's New 섹션
                    WhatsNewView()
                    // What's New 섹션 끝
                    
                    Spacer().frame(height: 20)
                    
                    // 배너 이미지 섹션
                    VStack {
                        Image("cup_banner")
                            .resizable()
                            .scaledToFit()
                        
                        Image("online_store_banner")
                            .resizable()
                            .scaledToFit()
                        
                        Image("delivery_service_banner")
                            .resizable()
                            .scaledToFit()
                    }
                    .padding(.horizontal, 10)
                    // 배너 이미지 섹션 끝
                    
                    // 디저트 섹션
                    RecommendDessertView()
                    // 디저트 섹션 끝
                    
                    Spacer().frame(height: 20)
                    
                    // 배너 이미지 섹션
                    VStack {
                        Image("coldbrew_banner")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 10)
                        
                        Image("barista_drink_banner")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 10)
                        
                        Image("starbuck_membership_banner")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 10)
                    }
                    .padding(.horizontal, 10)
                    // 배너 이미지 섹션 끝
                }
            }
            .ignoresSafeArea()
            // ScrollView 끝
        }
        // VStack 끝
        .onAppear{
            // 진입 시 광고창 등장
            showAdvertisementSheet = true
        }
        .sheet(isPresented: $showAdvertisementSheet) {
            AdvertisementView()
        }
    }
}

//---------------------------------------------
// 추천 메뉴 섹션
struct RecommendMenuView: View {
    @State private var viewModel = RecommendViewModel()
    @AppStorage("nickname") private var nickname: String = "(설정 닉네임)"
    @EnvironmentObject private var detailViewModel: MenuDetailViewModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("\(nickname)")
                    .font(.customPretend(.regular, size: 24))
                    .foregroundStyle(Color.customYellow)
                Text("님을 위한 추천 메뉴")
                    .font(.customPretend(.regular, size: 24))
                    .foregroundColor(.black)
            }
            .padding(.leading, 20)

            Spacer().frame(height: 25)

            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.coffeeItems) { coffee in
                        CircleImageCard(menu: coffee, detailViewModel: detailViewModel)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

//---------------------------------------------
// 왓츠뉴 섹션
//---------------------------------------------
struct WhatsNewView: View {
    @Bindable var viewModel = AdViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("What's new")
                .font(.customPretend(.regular, size: 24))
            
            Spacer().frame(height: 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.ads) { ad in
                        AdCard(ad: ad)
                            .frame(width: 300)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
    }
}
//---------------------------------------------
// 달콤달콤 디저트 색션
// 추천 메뉴 섹션
struct RecommendDessertView: View {
    @State private var viewModel = RecommendViewModel()
    @StateObject private var detailViewModel = MenuDetailViewModel()
    @EnvironmentObject private var router: NavigationRouter

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("하루가 달콤해지는 디저트")
                    .font(.customPretend(.semiBold, size: 24))
            }
            .padding(.leading, 20)
            
            Spacer().frame(height: 25)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.dessertItems) { dessert in
                        CircleImageCard(menu: dessert, detailViewModel: detailViewModel)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

//---------------------------------------------


#Preview {
    HomeView()
        .environmentObject(NavigationRouter())
        .environmentObject(MenuDetailViewModel())
}
