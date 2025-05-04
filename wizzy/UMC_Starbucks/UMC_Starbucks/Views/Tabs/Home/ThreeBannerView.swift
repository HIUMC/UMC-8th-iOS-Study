//
//  ThreeBannerView.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import SwiftUI

struct ThreeBannerView: View {
    var body: some View {
        VStack{
            Image("cupBanner")
            starBanner
            deliveryBanner
        }
        .padding(.top, 15)
        .padding(.horizontal, 10)
    }
    
    
    
    
    
    
    private var starBanner: some View {
        ZStack {
            Image("starBanner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 6)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("TIP")
                        .font(.PretendardSemiBold12)
                        .foregroundStyle(Color.grayB6)
                    
                    Text("온라인 스토어\n별★ 적립 혜택")
                        .font(.PretendardBold24)
                        .foregroundStyle(Color.black03)
                        .padding(.bottom, 16)
                    
                    Text("온라인 스토어 구매 시\n별★을 적립해 드립니다.")
                        .font(.PretendardBold16)
                        .foregroundStyle(Color.grayB6)
                }//v
                Spacer()
                    
            }//h
            .padding(.leading, 20)
        }//z
    }
    
    private var deliveryBanner: some View {
        ZStack {
            Image("deliveryBanner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .shadow(color: .black.opacity(0.06), radius: 2, x: 0, y: 6)
                .shadow(color: .black.opacity(0.1), radius: 2, x: 1, y: 1)
            
            HStack {
                VStack(alignment: .leading) {
                    
                    Text("딜리버스\n예약 배달 서비스")
                        .font(.PretendardBold22)
                        .foregroundStyle(Color.green006241)
                        .padding(.bottom, 16)
                    
                    Text("특별한 순간을 위해\n미리 예약해 보세요.")
                        .font(.PretendardBold16)
                        .foregroundStyle(Color.black02)
                }//v
                Spacer()
                    
            }//h
            .padding(.leading, 24)
        }//z
    }
    
    
    
    
    
    
    
}












#Preview {
    ThreeBannerView()
}
