//
//  StoreListView.swift
//  StarbuckApp
//
//  Created by 박병선 on 5/1/25.
//
import SwiftUI
import CoreLocation


struct StoreListView: View {
    let stores: [StoreFeature]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(stores, id: \.self) { store in
                    // 거리 계산
                    let userLocation = CLLocation(latitude: 37.5665, longitude: 126.9780) // 서울
                    let storeLocation = CLLocation(
                        latitude: store.properties.yCoordinate,
                        longitude: store.properties.xCoordinate
                    )
                    let distanceInMeters = userLocation.distance(from: storeLocation)
                    let distanceText = String(format: "%.1f km", distanceInMeters / 1000)

                    VStack(alignment: .leading, spacing: 6) {
                        HStack(alignment: .top, spacing: 12) {
                            // 매장 이미지
                            Image("storeSample")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 8))

                            VStack(alignment: .leading, spacing: 6) {
                                // 매장 이름
                                Text(store.properties.storeName)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                // 태그 + 거리
                                HStack {
                                    StoreTagsView(category: store.properties.category)

                                    Spacer()

                                    Text(distanceText)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                                // 주소
                                Text(store.properties.resolvedAddress ?? store.properties.address)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }

                            Spacer()
                        }

                        Divider()
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
            }
        }
    }
}

@ViewBuilder//뷰를 쪼갤거면 이걸 써야 된대
func StoreTagsView(category: StoreCategory) -> some View {
    HStack(spacing: 4) {
        if category == .reserve || category == .dtr {
            Image("RTag")
                .resizable()
                .frame(width: 18, height: 18)
        }
        if category == .dt || category == .dtr {
            Image("DTag")
                .resizable()
                .frame(width: 18, height: 18)
        }
    }
    
}

