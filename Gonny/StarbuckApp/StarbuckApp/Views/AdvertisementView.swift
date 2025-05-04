//
//  AdvertisementView.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/3/25.
//

//홈뷰에서 밑에 보이는 3개 광고 창 그냥 새로운 뷰로 빼버림

import SwiftUI

struct AdvertisementView: View{
    var body: some View{
        VStack(alignment: .leading, spacing: 14){
            Image("mugAD")
                .resizable()
                .scaledToFit()
                .frame(width:420, height: 217)
                .padding(.bottom, 14)
                  

            // 온라인 스토어 배너
            ZStack(alignment: .topLeading) {
                Image("onlineStore")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 420, height: 273)
                    .cornerRadius(16)

                VStack(alignment: .leading, spacing: 8) {
                    Text("TIP")
                        .font(.mainTextSemiBold13)
                        .foregroundColor(Color("gray00"))

                    Text("온라인 스토어\n별★ 적립 혜택")
                        .font(.mainTextBold24)
                        .foregroundColor(Color("black03"))
                        .padding(.top, 4)

                    Text("온라인 스토어 구매 시\n별★을 적립해 드립니다.")
                        .font(.mainTextSemiBold16)
                        .foregroundColor(Color("gray01"))
                        .padding(.top, 16)
                }
                .padding(.top, 48)
                .padding(.leading, 24)
            }
            
            ZStack(alignment: .topLeading) {
                Image("delivery")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 420, height: 218)

                VStack(alignment: .leading, spacing: 16) {
                    Text("딜리버리\n예약 서비스")
                        .font(.mainTextBold22)
                        .foregroundColor(Color("green03"))

                    Text("특별한 순간을 위해\n미리 예약해보세요")
                        .font(.mainTextBold16)
                        .foregroundColor(Color("black02"))
                }
                .padding(.leading, 24)
                .padding(.top, 48)
            }
            .cornerRadius(16) //
        }
    }
}

#Preview {
    AdvertisementView()
}
