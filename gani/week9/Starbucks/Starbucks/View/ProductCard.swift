//
//  ProductCard.swift
//  Starbucks
//
//  Created by 이가원 on 4/6/25.
//

import SwiftUI

struct ProductCard: View {
    let imageName: String
    let name: String

    var body: some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)

            Text(name)
                .font(.custom("Pretendard-SemiBold", size: 13))
                .multilineTextAlignment(.center)
        }
    }
}
