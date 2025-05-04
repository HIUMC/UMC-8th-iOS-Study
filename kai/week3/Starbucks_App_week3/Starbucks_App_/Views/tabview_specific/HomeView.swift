//
//  HomeView.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/27/25.
//

import SwiftUI

struct HomeView: View {
    @State private var path = NavigationPath()
    @State var currentStar : Int = 1

   
    @State private var desertViewModel = DesertDataViewModel()//디저트 뷰모델 추가
    @State private var newViewModel = NewViewModel()//디저트 뷰모델 추가
    
    @AppStorage("userName") private var userName: String?
    
    
    var body: some View {
        NavigationStack(path: $path){
            ScrollView(.vertical) {
                ZStack {
                    Image(.topImg)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack (alignment: .leading, spacing: 5){
                        Text("골든 미모사 그린 티와 함께 \n행복한 새해의 축배를 들어요!")
                            .font(.PretendardRegular24)
                        
                        Text("11 ⭑ until next Reward")
                            .font(.PretendardSemiBold16)
                            .foregroundStyle(.gaugebar)
                        
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                // 배경 바
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gaugebarBack)
                                    .frame(height: 10)
                                
                                // 채워진 부분
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gaugebar)
                                    .frame(width: geometry.size.width * (1 / 12), height: 10)
                            }
                        }
                        .frame(width: 256, height: 8)
                        .frame(height: 10)
                    }//텍스트+게이지바_VStack_end
                }//별포인트_ZStack_end
                //상단토끼뷰에는 옆에 여백이 없어서 따로 빼주었다
                Spacer()
                    .frame(height: 23)
                
                VStack{//개큰VStack
                    
                    //추천메뉴VStack
                    VStack{
                        
                        //텍스트 HStack(간격조정)
                        HStack{
                            Spacer()
                                .frame(width:10)
                            
                            Text("\(userName ?? "(설정 닉네임)")님을 위한 추천메뉴")
                            
                                .font(.PretendardRegular24)
                                .foregroundColor(.black)
                            Spacer()
                        }//텍스트HStack_end
                        .padding(.horizontal, 5)
                        
                        Spacer()
                            .frame(height:15)//피그마랑다름
                        
                        //추천메뉴카드뷰
                        RecommendView()
                            .padding(.vertical, 10)
                        
                    }//추천메뉴Vstack_end
                   
                        
                        //중간이벤트배너VStack
                        VStack{
                            Image(.eventBanner)
                                .resizable()
                                .scaledToFit()
                            Image(.serviceSuscibe)
                                .resizable()
                                .scaledToFit()
                            
                        }//중간이벤트배너VStack_end
                        .padding(.horizontal, 10)
                        //원래 스페이서로 넣으려고 했는데 HStack으로 해서...근데시간이없었어요...나중에수정하도록하겠음...아니면다른방법을찾아보거나....
                        
                        //What'sNew
                        HStack{
                            Spacer()
                                .frame(width:10)
                            
                            Text("What's New")
                                .font(.PretendardRegular24)
                                .foregroundColor(.black)
                            Spacer()
                        }//디저트텍스트HStack_end
                        .padding(.horizontal, 5)
                        
                        NewView(viewModel: newViewModel)
                            .padding(.vertical, 10)
                        
                        VStack{
                            
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
                        .padding(.horizontal, 5)//패딩
                        
                        //디저트텍스트HStack
                        HStack{
                            Spacer()
                                .frame(width:10)
                            
                            Text("하루가 달콤해지는 디저트")
                                .font(.PretendardRegular24)
                                .foregroundColor(.black)
                            Spacer()
                        }//디저트텍스트HStack_end
                        .padding(.horizontal, 5)
                        DesertView()
                            .padding(.vertical, 10)
                        
                        //나머지 이미지 VStack
                        VStack{
                            
                            Image(.advertisebanner)
                                .resizable()
                                .scaledToFit()
                            
                            Image(.coldbrewbanner)
                                .resizable()
                                .scaledToFit()
                            
                            Image(.baristafavorite)
                                .resizable()
                                .scaledToFit()
                            
                            Image(.sizeupbanner)
                                .resizable()
                                .scaledToFit()
                        }
                        .padding(.horizontal, 5) // 좌우 여백 추가(피그마랑 값 다름)
                        
                    }//개큰VStack_End
                    
                }
            
            }
        
        
        }//NavigationStack_end
        
    }

//추천메뉴뷰
struct RecommendView: View  {
    @State private var viewModel = RecommendViewModel()
    @AppStorage("nickname") private var nickname: String = "(설정 닉네임)"
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack{
                Text("\(nickname)")
                    .font(.PretendardRegular24)
                    .foregroundStyle(Color.gaugebar)
                Text("님을 위한 추천 메뉴")
                    .font(.PretendardRegular24)
                    .foregroundColor(.black)
            }
            .padding(.leading, 20)
            Spacer().frame(height: 25)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.coffeeDatas) { coffee in
                        CircleImageCard(coffee: coffee)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

//디저트뷰
struct DesertView: View{
    @State private var viewModel = DesertDataViewModel()
    
    var body: some View{
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) { // 항목 간격 설정
                ForEach(viewModel.Deserts) { desert in
                    VStack {
                        Image(desert.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80) // 원형 이미지 크기
                            .clipShape(Circle()) // 원형으로 자르기
                        
                        Text(desert.title)
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}


#Preview {
    HomeView()
}
