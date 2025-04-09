//
//  HomeView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/27/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing:0) {
                    bannerView()
                    Image(.bear)
                    RecommendView()
                    Image(.event)
                    Text("What's New")
                        .foregroundStyle(Color.black03)
                        .font(.mainTextBold24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.top, .leading])
                    
                    WhatsNewView()
                    VStack{
                        Image(.mug)
                        Image(.star1)
                        Image(.delivery)
                    }
                    DessertView()
                    
                    VStack{
                        Image(.down1)
                        Image(.down2)
                        Image(.down3)
                    }
                }
            }
            
        }
        //contentMargins(.top,-100)
       
    }
}

#Preview {
    HomeView()
}
