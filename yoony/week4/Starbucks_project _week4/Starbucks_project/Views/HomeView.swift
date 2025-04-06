//
//  HomeView.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/27/25.
//

import SwiftUI

struct HomeView: View {
   
    @StateObject private var viewModel = SignupViewModel()
    @State var currentStar : Int = 1
    var body: some View {
        
        NavigationStack{
            ScrollView{
                LazyVStack(spacing:20){
                    ZStack{
                        
                        Image("topFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 440, height: 259)
                            .ignoresSafeArea()
                        
                        Text("골든 미모사 그린 티와 함께 \n행복한 새해의 축배를 들어요!")
                            .font(.PretendardBold24)
                            .foregroundColor(.black03)
                            .offset(x:-40)
                            
                            
                        
                    }.ignoresSafeArea()
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(12 - currentStar)★ until next Reward")
                                .foregroundStyle(.brown01)
                                .font(.mainTextSemiBold16)
                            
                            Gauge(value: Double(currentStar), in: 0...12) {}
                                .gaugeStyle(.accessoryLinearCapacity)
                                .tint(.brown01)
                            
                        }.frame(width: 255)
                        
                        Spacer().frame(maxWidth: 36)
                        
                        HStack{
                            Text("\(currentStar)")
                                .font(.mainTextSemiBold38)
                            Text("/")
                                .foregroundStyle(.grey07)
                                .font(.PretendardSemiBold24)
                            Text("12")
                                .foregroundStyle(.brown02)
                                .font(.mainTextSemiBold24)
                            +
                            Text("★")
                                .foregroundStyle(.brown02)
                                .font(.mainTextSemiBold14)
                        }
                    }
                    
                    Image("AdvertisementTeddy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 420, height: 183)
                    
                    VStack(alignment: .leading){
                        Text(viewModel.storedname.isEmpty ? "(설정 닉네임)" : viewModel.storedname)
                            .foregroundColor(.brown01)
                            .font(.mainTextSemiBold24)
                        
                        
                        + Text("님을 위한 추천 메뉴")
                            .font(.mainTextSemiBold24)
                        
                        
                        CoffeeListView()
                        
                    }.padding(.leading, 20)
                    
                    Image("eventBanner")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 420, height: 451)
                        
                    
                    Image("serviceSubscribe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 420, height: 199)
                    
                    
                    WhatsnewListView()
                    
                    VStack(spacing: 0){
                        Image("MugcupBanner")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 420, height: 217)
                        
                        Image("OnlinestoreBanner")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 420, height: 272)
                        
                        Image("DeliveryBanner")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 420, height: 217)
                        
                    }
                    
                        BreadListView()
                        .padding(.leading, 20)

                        
                        
                        VStack{
                            Image("coldbrewBanner")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 420, height: 182)
                            Image("baristaFavoriteBanner")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 420, height: 360)
                            Image("starbuckssizeupBanner")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 420, height: 182)
                        }
                    }
                    
                }
            .navigationTitle(Text("홈"))
            }
        }
      
    }
    

#Preview {
    HomeView()
}
