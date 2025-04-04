//
//  HomeView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/2/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
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
                        .frame(width: 420, height: 450)
                    
                    Image("serviceSuscibe")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 420, height: 200)
                    Spacer()
                    
                    WhatsNewView()
                    ThreeBannerView()
                    DessertView()
                    UnderBannerView()
                    
                }
                
            }
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
