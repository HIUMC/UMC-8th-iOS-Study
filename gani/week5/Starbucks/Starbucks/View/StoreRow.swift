
//
//  S.swift
//  Starbucks
//
//  Created by 이가원 on 5/23/25.
//

import SwiftUI

struct StoreRow: View {
    let store: OrderSheetModel

    var body: some View {
        HStack(spacing: 16) {
            Image("storeImage")
                .resizable()
                .frame(width: 83, height: 83)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 3) {
                Text(store.name)
                    .font(.custom("Pretendard-SemiBold", size: 13))
                

                Text(store.address)
                    .font(.custom("Pretendard-Medium", size: 10))
                    .foregroundColor(.gray02)

                HStack(spacing: 4) {
                    if store.isReserve {
                        Image("reserve")
                            .resizable()
                            .frame(width:18, height:18)
                    }
                    if store.isDT {
                        Image("dt")
                            .resizable()
                            .frame(width:18, height:18)
                    }
                }
            }

            Spacer()

            if let dist = store.distance {
                Text(String(format: "%.1fkm", dist))
                    .font(.custom("Pretendard-Medium", size: 12))
            }
        }
    }
}
