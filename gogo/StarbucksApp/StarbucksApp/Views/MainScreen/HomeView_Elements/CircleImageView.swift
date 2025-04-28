///Users/koh/Desktop/UMC-8th/gogo/StarbucksApp/StarbucksApp/Views/TabView_Elements/HomeView_Elements/CircleImageView.swift
//  CircleImage.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/7/25.
//


import SwiftUI

struct CircleImageView: View {
    let imageName: String
    let title: String

    var body: some View {
        VStack(spacing: 8) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)

            Text(title)
                .font(.PretendardMedium14)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    CircleImageView(imageName: "menu1", title: "아메리카노")
}
