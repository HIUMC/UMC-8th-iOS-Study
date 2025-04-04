//
//  WhatsNewCard.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import SwiftUI

struct WhatsNewCard: View {
    let imageName: String
    let newsTitle: String
    let newsContent: String
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 10) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 242, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 5))

            Text(newsTitle)
                .font(.PretendardSemiBold18)
                .foregroundStyle(Color.black02)
                .kerning(-0.42)
                .multilineTextAlignment(.leading)
            
            Text(newsContent)
                .font(.PretendardSemiBold13)
                .foregroundStyle(Color.gray03)
                .multilineTextAlignment(.leading)
        }
        
        
        
    }
}

#Preview {
    WhatsNewCard(imageName: "new1", newsTitle: "25년 3월 일회용컵 없는 날 캠페.. ", newsContent: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매\n장에서 개인컵 및 다회용 컵을 이용하세요.")
}
