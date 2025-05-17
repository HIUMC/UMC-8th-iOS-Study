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

@ViewBuilder
func StoreTagsView(category: StoreCategory) -> some View {
    HStack(spacing: 4) {
        if category == .reserve || category == .both {
            Image("RTag")
                .resizable()
                .frame(width: 18, height: 18)
        }
        if category == .dt || category == .both {
            Image("DTag")
                .resizable()
                .frame(width: 18, height: 18)
        }
    }
    
}


/*
struct StoreListView: View {
    let stores: [StoreFeature]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(stores, id: \.self) { store in
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

                                // 태그 + 거리 수평 정렬
                                HStack {
                                    HStack(spacing: 4) {
                                        if store.properties.category == .reserve || store.properties.category == .both {
                                            Image("RTag")
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                        }
                                        if store.properties.category == .dt || store.properties.category == .both {
                                            Image("DTag")
                                                .resizable()
                                                .frame(width: 18, height: 18)
                                        }
                                    }

                                    Spacer()

                                    // 거리를 계산하여 표시 (예: 1.2 km)
                                    let userLocation = CLLocation(latitude: 37.5665, longitude: 126.9780)//서울로 초기설정
                                    let storeLocation = CLLocation(latitude: store.properties.yCoordinate, longitude: store.properties.xCoordinate)
                                    let distanceInMeters = userLocation.distance(from: storeLocation)
                                    Text(String(format: "%.1f km", distanceInMeters / 1000))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }

                                // 주소 표시
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
*/


/*
import SwiftUI

struct StoreListView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
*/


