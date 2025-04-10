//
//  HomeView.swift
//  Starbucks_Week1_gogo
//
//  Created by 고석현 on 4/1/25.
//

//커피 이미지 tapgesutUre로 DetailCoffeeView로 이동 안돼요ㅠㅠ
//지피티도 돌려보고 코드 계속 봐도 어떻게 로직 구상해야할지 막힙니다

import SwiftUI

//큰 틀 --->  ScrollView 안에 LazyHStack 안에 하위뷰들 (필요한 렌더링만 해서 일반 HStack 보다 성능 effenciency 낫대..)

struct HomeView: View {
    @AppStorage("nickname") var nickname: String = "(작성한 닉네임)"
    
    //전역적 관리..하고싶은데
//    @EnvironmentObject var navigationRouter: NavigationRouter // NavigationRouter 주입
    @State var viewModel: HomeViewModel = .init()
    


    
    
    var body: some View {
        
        NavigationStack {
            ScrollView(.vertical) {
                LazyVStack(spacing:20) {
                    topBanner //골든미모사 블라 ~ z스택 기본
                    topBanner2 //게이지바 & 주변 텍스트!게이지바 익히자..복습.
                    
                    Image(.iceChallenge)   // 아이스 챌린지 이미지 pdf
                        .resizable()
                        .padding(.horizontal, 10)
                    
                    RecommendedMenu //커피 추천 메뉴 가로스크롤뷰(네비게이션)
                    
                    Image(.eventBanner)//이벤트 배너 이미지 pdf
                        .resizable()
                        .padding(.horizontal, 10)
                    
                    Image(.subscribe)//구독 배너 이미지 pdf
                        .resizable()
                        .padding(.horizontal, 10)
                    whatsNew
                    midBanner //중간광고
                    dessertMenu //빵 디저트 horizontal ScrollView
                    bottomBanner //하단 배너 광고
                    
                    
                }
            }
            .scrollIndicators(.hidden) //스크롤바 없애기 showIndicatofs:False 는 depecrated 이래
            //navigationDestination
            .navigationDestination(for: Route.self) { route in
                            switch route {
                            case .signUp:
                                SignupView()
                            case .tabBarView:
                                TabBarView()
                            case .login:
                                LoginView(viewModel: LoginViewModel())
                            case .detailCoffee:
                                DetailCoffeeView(viewModel: HomeViewModel())
                            case .ad:
                                AdView()
                            }
                        }
        }
    }
    
    
    //------------------------------------------------------------//
    private var topBanner: some View {
        ZStack {
            Image(.topImg)
                .resizable() //
                .scaledToFill() // 비율 유지하며 화면 채우기
                .frame(maxWidth: .infinity, minHeight: 226) // Figma 기준 높이 맞추기
                .clipped() // 넘치는 부분 자르기
            
            
            
            
            
            VStack{
                Text("골든 미모사 그린티와 함께 \n행복한 새해의 축배를 들어요!")
                    .font(.custom("Pretendard-Bold", size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 120)
                    .padding(.leading, 28.16)
                HStack{
                    Text("내용 보기")
                        .font(.custom("Pretendard-Regular", size: 13))
                        .foregroundStyle(.gray06)
                        .padding(.leading, 350.37)
                    Spacer().frame(width:4)
                    Image(.goLine)
                    Spacer().frame(width:21)
                    
                }
                
            }
        }
        
        .scaledToFill() // ✅ 비율 유지하며 화면 채우기 여기에도 했어야함
        .frame(maxWidth: .infinity, minHeight: 200)
        .ignoresSafeArea(.all)
    }
    //게이지바 위와 옆 텍스트 & 게이지바
    private var topBanner2: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 6) {
                Text("11★ until next Reward")
                    .foregroundColor(Color("brown02"))
                    .font(.custom("Pretendard-SemiBold", size: 16))
                
                GaugeBar(numb: 1, total: 12)
                    .frame(width: 255, height: 8)
            }
            
            Spacer()
            
            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text("1")
                    .font(.PretendardSemiBold38)
                
                Text("/")
                    .font(.PretendardSemiBold24)
                    .foregroundColor(Color("gray00"))
                
                Text("12")
                    .font(.PretendardSemiBold24)
                    .foregroundColor(Color("brown01"))
                
                Text("★")
                    .font(.PretendardSemiBold14)
                    .foregroundColor(Color("brown01"))
            }
            .padding(.trailing, 16)
        }
        .padding(.horizontal, 20)
    }
    
    //게이지바 지피티..
    struct GaugeBar: View {
        let numb: Int
        let total: Int
        
        var body: some View {
            let ratio = CGFloat(numb) / CGFloat(total)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.gray00)
                    .frame(width:255,height: 8)
                
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.brown01)
                    .frame(width:255 * ratio, height: 8) //색 채우라
            }       //Z스택이니까 겹쳐지지만 괜찮음 갈색이 회색 덮어
            // 높이고정, 너비를 비율에 맞춰서 조정
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 28)
        }
    }
    
    //커피 추천메뉴 닉네임 받아와야하니까 텍스트 따로, ScrollView 따로 ~
    private var RecommendedMenu: some View {
        VStack(alignment: .leading) {
            HStack {
                Group {
                    Text("\(nickname)님")
                        .foregroundStyle(.brown01)
                        .padding(.leading,19)
                    Text("을 위한 추천 메뉴")
                        .foregroundStyle(.black03)
                }
                .font(.PretendardBold24)
                Spacer()
            }
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(RecommendModel.dummy) { menu in
                        CircleImageView(imageName: menu.imageName, title: menu.title)
                    }
                }
                .padding(.horizontal, 19)
//                .onTapGesture {navigationRouter.push(.detailCoffee) // Push to DetailCoffeeView
//                                        }
                
                .scrollIndicators(.hidden)
            }
            
        }
    }
    
    
    
    //What's New 그리고 NewCardView 하위뷰 만들어서  반복문 사용.
    //WhatsNewModel의 있는 dummy 배열 순회하며 NewCardView에 전달.
    //아 글자 줄바꿈이 왜안되노
    private var whatsNew: some View {
            VStack {
                HStack {
                    Text("What's New")
                        .foregroundStyle(.black03)
                        .font(.PretendardSemiBold18)
                        .padding(.leading, 20)
                    Spacer()
                }
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 16) {
                        ForEach(WhatsNewModel.dummy, id: \.self) { newcard in
                            NewCardView(imageName: newcard.imageName, title: newcard.title, text: newcard.text)
                        }
                    }
                    
                }
                .scrollIndicators(.hidden)
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
        }
    
    private var midBanner: some View {
        VStack {
            Image(.image1)
                .resizable()
                .padding(.horizontal, 10)
            Image(.image2)
                .resizable()
                .padding(.horizontal, 10)
            Image(.image3)
                .resizable()
                .padding(.horizontal, 10)
              
        }
    }
    
    private var dessertMenu: some View {
           VStack {
               HStack {
                   Text("하루가 달콤해지는 디저트")
                       .font(.PretendardBold24)
                       .foregroundStyle(.black03)
                       .padding(.leading, 20)
                   Spacer()
               }
               ScrollView(.horizontal) {
                   LazyHStack(spacing: 16) {
                       ForEach(DessertModel.dummy, id: \.self) { dessert in
                           VStack {
                               CircleImageView(imageName: dessert.imageName, title: dessert.title)
                               
                               
                           }
                       }
                   }
               }
               .scrollIndicators(.hidden)
           }
       }
    private var bottomBanner: some View {
        VStack{
            Image(.bottom1)
                .resizable()
                .padding(.horizontal, 10)
            Image(.bottom2)
                .resizable()
                .padding(.horizontal, 10)
            Image(.bottom3)
                .resizable()
                .padding(.horizontal, 10)
            
        }
    }
    

    
    
}
    
    
    
    
    








#Preview {
    HomeView()
           .environmentObject(NavigationRouter()) // NavigationRouter를 Preview에 전달
}
