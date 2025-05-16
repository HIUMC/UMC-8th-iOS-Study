//
//  HomeView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/2/25.
//

// 비상~!!!!!!!!!!!!!!!!! 갑자기 왜 양쪽 패딩이 안 먹히지

import SwiftUI

struct HomeView: View {
    @State private var showPopup = true
    
    var body: some View {
       NavigationStack{
            ZStack {
                /*
                if showPopup {
                    PopupView(showPopup: $showPopup)
                        .padding(.horizontal, 30)
                        .transition(.opacity)
                        .zIndex(1)
                }
                 */
                
                ScrollView {
                    VStack {
                        ZStack {
                            topBanner
                            ProgressBarView()
                        } //z
                        Image("bearBanner")
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 6)
                            .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
                        RecommendView()
                        
                        Image("bloomingBanner")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                        
                        Image("serviceSuscibe")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity)
                        Spacer()
                        
                        WhatsNewView()
                            .padding(.leading, 10)
                        ThreeBannerView()
                        
                        DessertView()
                            .padding(.leading, 20)
                        UnderBannerView()
                        
                    }
                    //.padding(.horizontal, 30) 해도 안 먹히네
                }
                .ignoresSafeArea() //스크롤뷰
                
            }
            //.padding(.horizontal, 16)
        }
        
    }
}

private var topBanner: some View {
    ZStack { //z1
        Image("topBanner")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .ignoresSafeArea(edges: .top)
    }
}
    


#Preview {
    HomeView()
}
