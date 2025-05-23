//
//  StoreCardView.swift
//  Starbucks
//
//  Created by 박정환 on 5/2/25.
//

import SwiftUI

struct StoreCardView: View {
    let model: StoreFeature
    
    init(model: StoreFeature) {
        self.model = model
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Image("storeImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 83, height: 83)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 3) {
                    Text(model.properties.Sotre_nm)
                        .foregroundStyle(.black03)
                        .font(.pretendardSemiBold(13))
                    
                    Text(model.properties.Address)
                        .foregroundStyle(.gray02)
                        .font(.pretendardMedium(10))
                }
                
                HStack(alignment: .center, spacing: 0) {
                    HStack(spacing: 4) {
                        if model.properties.storeCategory == .reserve || model.properties.storeCategory == .dtr {
                            Image("R")
                        }
                        if model.properties.storeCategory == .dt || model.properties.storeCategory == .dtr {
                            Image("D")
                        }
                    }
                    
                    Spacer()
                    
                    Text("\(String(format: "%.1f km", model.properties.KM ?? 0.0))")
                        .font(.pretendardMedium(12))
                }
            }
        }
    }
}
