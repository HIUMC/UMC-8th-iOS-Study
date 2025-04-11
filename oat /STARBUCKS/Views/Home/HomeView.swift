//
//  HomeView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/27/25.
//

import SwiftUI

struct HomeView: View {
    @State private var show: Bool = true
    var body: some View {
            ScrollView {
                VStack(spacing:0) {
                    bannerView()
                        .padding(.top,-20)
                        .ignoresSafeArea(.all)
                        //.padding(.horizontal)
                    Image(.bear)
                    RecommendView()
                        .padding(.horizontal)
                    Image(.event)
                    Text("What's New")
                        .foregroundStyle(Color.black03)
                        .font(.mainTextBold24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .leading])
                        .padding(.horizontal)
                    
                    WhatsNewView()
                        .padding(.horizontal)
                    VStack{
                        Image(.mug)
//                            .padding(.horizontal)
                        Image(.star1)
                        
                        Image(.delivery)
                    }
                    
                    DessertView()
                        .padding(.horizontal)
                    
                    VStack{
                        Image(.down1)
                        Image(.down2)
                        Image(.down3)
                       .padding(.bottom,80)
                    }
                
                }
                
            
            
        }
           .ignoresSafeArea()
//           .padding(.top,-90)
           .navigationBarBackButtonHidden(true)
           .toolbar(.hidden, for: .navigationBar)
//           .fullScreenCover(isPresented: $show) {
 //              AdvertiseView()
  //         }
           
        //.padding(.top, -100)
            //.padding(.horizontal)
       
    }
}

#Preview {
    HomeView()
}
