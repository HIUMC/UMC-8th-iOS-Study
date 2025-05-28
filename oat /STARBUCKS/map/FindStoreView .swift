//
//  FindStoreView .swift
//  STARBUCKS
//
//  Created by 신민정 on 5/2/25.
//

import SwiftUI
import CoreLocation


struct FindStoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTab: FindStoreTab = .findStore
    @State private var selectedTop: FindStoreTopSegment = .findStore
    @State private var currentMapCenter: CLLocationCoordinate2D? = nil


    
    @State private var hasMoved = false
    @State private var displayedStores: [Store] = []
    
    @StateObject var storeDataManager = StoreDataManager()
    
    var body: some View {
        VStack(spacing: 0) {
            // 상단 네비 + 세그먼트
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                }
                Spacer()
                Text("매장 찾기")
                    .font(.mainTextMedium16)
                Spacer()
                Spacer().frame(width: 24)
            }
            .padding()
            
            topSegment()

            // 지도 뷰
            StoreMapViewUIKit(
                stores: storeDataManager.stores,
                hasMoved: $hasMoved,
                displayedStores: $displayedStores,
                userLocation: storeDataManager.userLocation,
                onRegionChange: { center in
                    self.currentMapCenter = center
                }
            )
            .onAppear {
                if let center = storeDataManager.userLocation?.coordinate {
                    updateDisplayedStores(center: center)
                }
            }
            .overlay(
                VStack {
                    if hasMoved {
                        Button("이 지역 검색") {
                            if let center = currentMapCenter {
                                updateDisplayedStores(center: center)
                            }
                            hasMoved = false
                        }
                        .font(.caption)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.white)
                        .foregroundStyle(.black)
                        .clipShape(Capsule())
                        .shadow(radius: 4)
                        .padding(.top, 30)
                        Spacer()
                    }
                }
            )
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationBarBackButtonHidden(true)

    }
    
    private func topSegment() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(FindStoreTopSegment.allCases, id: \.self) { segment in
                    Button {
                        withAnimation(.easeInOut) {
                            selectedTop = segment
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Text(segment.rawValue)
                                .font(.mainTextSemibold16)
                                .foregroundStyle(
                                    selectedTop == segment
                                    ? Color.black
                                    : Color.black.opacity(0.5)
                                )
                            Rectangle()
                                .fill(selectedTop == segment ? Color("brown02") : Color.clear)
                                .frame(height: 3)
                                .clipShape(RoundedRectangle(cornerRadius: 1.5, style: .continuous))
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .background(Color.white.shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2))
        }
    }

    
    // 세그먼트 버튼
    private func segmentButton(title: String, tab: FindStoreTab) -> some View {
        Button(action: {
            selectedTab = tab
        }) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(selectedTab == tab ? .green : .gray)
                .padding()
                .frame(maxWidth: .infinity)
                .background(selectedTab == tab ? Color.white : Color.clear)
        }
    }
    
    // 매장 필터링
    private func updateDisplayedStores(center: CLLocationCoordinate2D) {
        let base = CLLocation(latitude: center.latitude, longitude: center.longitude)
        displayedStores = storeDataManager.stores.filter {
            let loc = CLLocation(latitude: $0.latitude, longitude: $0.longitude)
            return base.distance(from: loc) / 1000 <= 10
        }
    }
}



// 탭 선택 상태
enum FindStoreTab {
    case findStore
    case directions
}

enum FindStoreTopSegment: String, CaseIterable {
    case findStore = "매장 찾기"
    case directions = "길찾기"
}



