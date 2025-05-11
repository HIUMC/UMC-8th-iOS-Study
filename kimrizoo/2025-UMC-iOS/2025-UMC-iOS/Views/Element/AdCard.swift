//
//  AdCard.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/3/25.
//

import SwiftUI

struct AdCard: View {
    let ad: AdItem
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(ad.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(5)
            
            Spacer().frame(height: 16)
            
            Text(ad.title)
                .font(.customPretend(.medium, size: 18))
            
            Spacer().frame(height: 9)
            
            Text(ad.description)
                .font(.customPretend(.regular, size: 13))
                .foregroundStyle(Color.customGray2Color)
                .frame(height: 36)
        }
    }
}

#Preview {
    AdCard(ad: AdItem(
        title: "25년 3월 일회용컵 없는 날 캠페인",
        description: "매월 10일은 일회용컵 없는 날! 스타벅스 매장에서 개인컵 및 다회용 컵을 이용하세요.",
        imageName: "ad_campaign"
    ))
}

