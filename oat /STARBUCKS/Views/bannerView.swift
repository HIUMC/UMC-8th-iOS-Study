//
//  bannerView.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/28/25.
//

import SwiftUI

struct bannerView: View {
    var body: some View {
        ZStack() {
            Image(.banner)
            VStack(alignment: .leading ) {
                Spacer().frame(height:120)
                ( Text("골든 미모사 그린 티와 함께")
                  +
                  Text("\n행복한 새해의 축배를 들어요!"))
                .lineSpacing(5)
                .font(.mainTextBold24)
                .padding()
                
                HStack() {
                    VStack(alignment: .leading) {
                        Text("11★ until next Reward")
                            .foregroundStyle(Color.brown02)
                            .font(.mainTextSemibold16)
                        ProgressBarView()
                        
                    }
                    
                    
                    HStack {Text("1")
                            .font(.mainTextSemiBold38)
                            .foregroundStyle(Color.black03)
                        Text("/")
                            .font(.mainTextLight24)
                            .foregroundStyle(Color(red: 0.79, green: 0.79, blue: 0.79))
                        Text("12★")
                            .font(.mainTextSemibold24)
                            .foregroundStyle(Color.brown02)
                        
                    }
                    
                }
                .padding()
                
                
            }
                
        }
    }
}

#Preview {
    bannerView()
}

import SwiftUI

struct ProgressBarView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color(red: 0.86, green: 0.86, blue: 0.86))
                Capsule()
                    .fill(Color.brown01)
                    .frame(width: geometry.size.width * 0.2, height: 10)
            }
        }
        .frame(height: 10)
    }
}
