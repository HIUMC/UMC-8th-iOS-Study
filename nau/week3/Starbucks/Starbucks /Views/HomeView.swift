//
//  HomeView.swift
//  Starbucks
//
//  Created by nau on 3/26/25.
//

import SwiftUI

struct HomeView: View {
    @State var currentStar : Int = 1
    
    //계산된 비율
    var starRatio: Double {
        Double(currentStar) / 12.0
    }
    
    var body: some View {
        topView
        
        Spacer()
    }
    
    private var topView: some View {
        ZStack(alignment: .leading) {
            Image(.topImg)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("골든 미모사 그린 티와 함께\n행복한 새해의 축배를 들어요!")
                    .font(.mainTextBold24)
                    .foregroundStyle(.black03)
                
                Spacer().frame(maxHeight: 29)
                
                gaugeView
                
            }
            .frame(maxWidth: 380)
            .offset(y: -10)
        }
    }
    
    private var gaugeView: some View {
        HStack {
            VStack {
                Text("\(12 - currentStar)★ until next Reward")
                    .font(.mainTextSemibold16)
                    .foregroundStyle(.brown01)
                
                //gauge height, 배경 컬러 설정 어케 하는거지?
                Gauge(value: starRatio) {}
                .tint(.brown01)
                .frame(maxWidth: 255)
            }
        }
    }
}

#Preview {
    HomeView()
}
