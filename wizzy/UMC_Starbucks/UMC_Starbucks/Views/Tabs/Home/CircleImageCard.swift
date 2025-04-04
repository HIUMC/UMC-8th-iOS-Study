//
//  CircleImageCard.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import SwiftUI

struct CircleImageCard: View {
    let imageName: String
    let coffeetitle: String

    var body: some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
                .clipShape(Circle())

            Text(coffeetitle)
                .font(.PretendardSemiBold14)
                .foregroundStyle(Color.black02)
                .multilineTextAlignment(.center)
                .kerning(-0.42)
        }
        //.frame(width: 110)
    }
}

#Preview {
    CircleImageCard(imageName: "confana", coffeetitle: "커피 이름")
}
