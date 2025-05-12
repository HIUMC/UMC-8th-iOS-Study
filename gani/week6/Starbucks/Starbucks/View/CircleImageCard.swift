//
//  CircleImageCard.swift
//  Starbucks
//
//  Created by 이가원 on 4/5/25.
//

import SwiftUI

struct CircleImageCard: View {
    let imageName: String
    let name: String

    var body: some View {
        VStack(spacing: 8) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)

            Text(name)
                .font(.custom("Pretendard-Medium", size: 14))
                .multilineTextAlignment(.center)
        }
    }
}
