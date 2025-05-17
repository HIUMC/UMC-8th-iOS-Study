//
//  Untitled.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/29/25.
//
import SwiftUI
//커피리스트 보여주는
struct OrdercoffeeItemView: View {
    let coffee: OrderCoffeeItem

    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 50, height: 50)
                .overlay(
                    Image(coffee.imageName)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(coffee.name)
                    .font(.headline)
                Text(coffee.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
