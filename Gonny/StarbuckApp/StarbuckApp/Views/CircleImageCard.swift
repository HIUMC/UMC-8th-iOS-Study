//
//  CircleImageCard.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/3/25.
//
import SwiftUI
import Foundation

struct CircleImageCard<Item: ImageCardItem>: View {
    let item: Item

    var body: some View {
        VStack {
            Image(item.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 130, height: 130)
                .clipShape(Circle())
            Text(item.name)
                .font(.mainTextSemiBold14)
                .foregroundColor(Color("black02"))
                .multilineTextAlignment(.center)
                .padding(.top, 10)
        }
        .frame(width: 100)
    }
}


#Preview {
    CircleImageCard(item: RecommendMenu(name: "아이스 아메리카노", imageName: "coffee1"))
}
