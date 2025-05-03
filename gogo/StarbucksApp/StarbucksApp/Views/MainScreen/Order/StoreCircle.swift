//
//  StoreCircle.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/1/25.
//

import SwiftUI

struct StoreCircle: View {
    let storeName: String
    let storeAddress: String
    let category: StoreCategory
    let distance: Double

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "location.circle")
                .resizable()
                .frame(width: 83, height: 83)

            textStack

            
            Spacer()
            Text(String(format: "%.1f km", distance / 1000))
                    .font(.pretend(type: .medium, size: 12))
                    .foregroundStyle(.black01)
            
        }
        .frame(maxWidth: .infinity, minHeight: 84)
        .padding(.horizontal,32.5)
    }

    private var textStack: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(storeName)
                .font(.PretendardSemiBold13)
                .foregroundStyle(.black03)
            Text(storeAddress)
                .font(.pretend(type: .medium, size: 10))
                .foregroundStyle(.gray02)

            if category != .none {
                specialStore
            }
        }
        .padding(.vertical, 6)
    }

    private var specialStore: some View {
        HStack(spacing: 4) {
            Image(category == .reserve ? "reserve" : "dt")
                .resizable()
                .frame(width: 18, height: 18)

            if category == .reserve {
                Image("dt")
                    .resizable()
                    .frame(width: 18, height: 18)
            }
        }
        .padding(.top, 13)
    }
}

#Preview {
    StoreCircle(
        storeName: "스타벅스 강남점",
        storeAddress: "서울 강남구 테헤란로",
        category: .reserve,
        distance: 1530
    )
}
