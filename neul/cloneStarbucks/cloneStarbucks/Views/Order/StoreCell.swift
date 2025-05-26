//
//  StoreCell.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/29/25.
//

import SwiftUI
import Kingfisher

struct StoreCell: View {
    
    let storeName: String
    let storeAddress: String
    let category: StoreCategory
    let distance: Double
    let imageData: String?
    
    var body: some View {
        HStack(spacing: 16) {
            if let imageUrl = URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(imageData ?? "")&key=\(Config.googleApiKey)") {
                KFImage(imageUrl)
                    .placeholder({
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 83, height: 83)
                    })
                    .resizable()
                    .frame(width: 83, height: 83)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                
            }
            
            textStack
            Spacer()
            VStack {
                Spacer()
                Text(String(format: "%.1f km", distance / 1000))
                    .font(.pretend(type: .medium, size: 12))
                    .foregroundStyle(.black01)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 84)

    }
    
    private var textStack: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(storeName)
                .font(.MainTextSemiBold13)
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
            Image(category == .reserve ? "reserve": "dt")
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


