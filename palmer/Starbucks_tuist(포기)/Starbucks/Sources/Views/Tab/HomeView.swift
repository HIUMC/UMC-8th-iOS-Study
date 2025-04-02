//
//  HomeView.swift
//  Starbucks
//
//  Created by 박정환 on 3/31/25.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("nickname") private var nickname: String = "(설정 닉네임)"
    @State private var router = NavigationRouter()
    @Environment(HomeViewModel.self) var viewModel

    
    var body: some View {
        ScrollView {
            bannerView
            Image("adbanner")
                .padding(.horizontal, 10)
            recommendView
            
        }
        .ignoresSafeArea(.all)
    }
}

//최상단 배너
private var bannerView: some View {
    ZStack(alignment: .bottomLeading) {
        Image("top_img")
        
        VStack(alignment: .leading) {
            Text("골든 미모사 그린 티와 함께\n행복한 새해의 축배를 들어요!")
                .font(.mainTextBold24)
                .foregroundStyle(.black03)
                .frame(maxHeight: 72)
            
            //배너 하단
            HStack(alignment: .bottom) {
                //게이지바
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
            .padding(.bottom, 5)
        }
        .padding(.horizontal, 28)
    }
}

private var recommendView: some View {
    VStack(alignment: .leading, spacing: 25) {
                HStack(spacing: 0) {
                    Text(nickname)
                        .foregroundStyle(.brown01)
                        .font(.pretendardBold(24))
                    Text("님을 위한 추천 메뉴")
                        .foregroundStyle(.black)
                        .font(.pretendardBold(24))
                }
                .padding(.horizontal, 10)
                
                ScrollView(.horizontal, content: {
                    LazyHStack(spacing: 16, content: {
                        ForEach(viewModel.dummyCoffees, id: \.id) { coffee in
                            CircleImageCard(model: coffee)
                                .onTapGesture {
                                    viewModel.selectedCoffeeModel = coffee
                                    router.push(.coffeeDetail)
                                }
                        }
                    })
                })
                .scrollIndicators(.hidden)
                .padding(.leading, 10)
            }
}


#Preview {
    HomeView()
}
