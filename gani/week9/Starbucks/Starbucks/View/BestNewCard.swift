//
//  BestNewCard.swift
//  Starbucks
//
//  Created by 이가원 on 4/6/25.
//

import SwiftUI

struct BestNewCard: View {
    let imageName: String
    let title: String

    var body: some View {
        VStack(spacing: 8) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 135)

            Text(title)
                .font(.custom("Pretendard-SemiBold", size: 14))
                .multilineTextAlignment(.center)
        }
        .frame(width: 130)
    }
}
