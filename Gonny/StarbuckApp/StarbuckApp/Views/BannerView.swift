//
//  BannerView.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/3/25.
//
import SwiftUI

struct BannerView: View {
    var body: some View {
        ZStack//(alignment: .top)
        {
            Image("top_image")
                .resizable()
                .scaledToFill()
                .frame(height: 226)
                //.clipped()
                .edgesIgnoringSafeArea(.top)
            
            VStack(alignment: .leading) {
                Text("골든 미모사 그린 티와 함께\n행복한 새해의 축배를 들어요!")
                    .lineSpacing(5)
                    .font(.mainTextSemiBold24)
                    .foregroundStyle(Color("black03"))
                    .padding(.leading, 28)
                
                HStack {
                    RewardProgressView()
                    
                    Spacer()
                    
                    HStack {
                        Text("1")
                            .font(.mainTextSemiBold38)
                            .foregroundStyle(Color("black03"))
                        Text("/")
                            .font(.mainTextLight24)
                            .foregroundStyle(Color(red: 0.79, green: 0.79, blue: 0.79))
                        Text("12★")
                            .font(.mainTextSemiBold24)
                            .foregroundStyle(Color("brown02"))
                    }
                }
                .padding()
            }
        }
        
        .frame(height: 226)
    }
}

#Preview {
    BannerView()
}

struct RewardProgressView: View {
    let currentStars: Int = 11
    let totalStars: Int = 12
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(currentStars)★ until next Reward")
                .font(.mainTextMedium16)
                .foregroundStyle(Color("black02"))
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color("gray04"))
                        .frame(height: 8)
                    
                    Capsule()
                        .fill(Color("brown02"))
                        .frame(width: geometry.size.width * CGFloat(currentStars) / CGFloat(totalStars), height: 8)
                }
            }
            .frame(height: 8)
        }
        .padding(.horizontal, 20)
    }
}
