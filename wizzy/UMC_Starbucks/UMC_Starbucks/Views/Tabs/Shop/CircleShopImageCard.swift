//
//  CircleShopImageCard.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/6/25.
//


import SwiftUI

struct CircleShopImageCard: View {
    let imageName: String
    let prodTitle: String

    var body: some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
            
            
            Text(prodTitle)
                .font(.PretendardSemiBold14)
                .foregroundStyle(Color.black02)
                .multilineTextAlignment(.center)
                .kerning(-0.42)
        }
        .frame(height: 90)
            
    }
}

#Preview {
    CircleImageCard(imageName: "confana", coffeetitle: "커피 이름")
}
