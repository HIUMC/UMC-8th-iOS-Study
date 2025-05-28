//
//  StoreLow.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/23/25.
//

/*
import SwiftUI
import Kingfisher

struct StoreRow: View {
    let store: Feature

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top, spacing: 12) {
                let apiKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_API_KEY") as? String ?? ""

                if let photoReference = store.properties.photoReference {
                    let imageUrl = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\(photoReference)&key=\(apiKey)"
                    KFImage(URL(string: imageUrl))
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                } else {
                    Image("placeholderImage")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(store.properties.storeName)
                        .font(.headline)

                    Text(store.properties.address)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.bottom, 15)

                    HStack {
                        if store.properties.category.contains("리저브") {
                            Image("rIcon")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        if store.properties.category.contains("DT") {
                            Image("dIcon")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        Spacer()
                        if let distance = store.distanceFromUser {
                            Text(String(format: "%.1fkm", distance))
                                .font(.PretendardRegular12)
                                .foregroundStyle(Color.black03)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 23)
    }
}
*/
