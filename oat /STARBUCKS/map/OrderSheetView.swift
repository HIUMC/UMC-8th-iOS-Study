//
//  OrderSheetView.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/28/25.
//

import SwiftUI
import CoreLocation

struct OrderSheetView: View {
    @StateObject var storeDataManager = StoreDataManager()
    // 매장 목록과 사용자 위치를 관리하는 뷰모델
    
    @State private var isMapView = false
    // true면 지도뷰, false면 리스트뷰
    
    @State private var mapCenter: CLLocationCoordinate2D?

    
    @State private var selectedTab: StoreTab = .nearby
    // 가까운 매장 vs 자주가는 매장 탭 선택 상태
    
    @State private var hasMoved = false
    @State private var displayedStores: [Store] = []
    
    var body: some View {
        NavigationStack {
            Group {
                if isMapView {
                    // 지도 뷰 UIKit 버전으로 교체
                    StoreMapViewUIKit(
                        stores: storeDataManager.stores,
                        hasMoved: $hasMoved,
                        displayedStores: $displayedStores,
                        userLocation: storeDataManager.userLocation,
                        onRegionChange: { center in
                            self.mapCenter = center
                        }
                    )

                    .overlay(
                        VStack {
                            if hasMoved {
                                Button("이 지역 검색") {
                                    // 현재 지도 중심 좌표로 10km 필터링
                                    if let center = mapCenter {
                                        storeDataManager.updateDisplayedStores(center: center)

                                    }
                                    hasMoved = false

                                }
                                .font(.mainTextMedium12)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .foregroundStyle(.gray06)
                                .clipShape(Capsule())
                                .shadow(radius: 4)
                                .padding(.top, 30)
                                Spacer()
                            }
                        }
                    )
                    .onAppear {
                        // 최초 지도 뷰 열릴 때 10km 매장 미리 필터링
                        if let center = storeDataManager.userLocation?.coordinate {
                            storeDataManager.updateDisplayedStores(center: center)
                        }
                    }
                } else {
                    VStack(spacing: 0) {
                        searchBar
                        storeSegment
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(filteredStores) { store in
                                    HStack(alignment: .top, spacing: 16) {
                                        Rectangle()
                                            .fill(Color.gray)
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                                        VStack(alignment: .leading, spacing: 6) {
                                            // 매장 이름과 주소
                                            Text(store.name)
                                                .font(.mainTextSemiBold13)

                                            Text(store.address)
                                                .font(.mainTextMedium10)
                                                .foregroundColor(.gray)

                                            // 매장이 reserve인지 드라이브 스루인지
                                            HStack(spacing: 4) {
                                                if store.category == .reserve {
                                                    HStack {
                                                        Image("rTag")
                                                            .resizable()
                                                            .frame(width: 18, height: 18)
                                                        Image("dTag")
                                                            .resizable()
                                                            .frame(width: 18, height: 18)
                                                    }
                                                }
                                                if store.category == .driveThru {
                                                    Image("dTag")
                                                        .resizable()
                                                        .frame(width: 18, height: 18)
                                                }
                                            }
                                        }

                                        Spacer()

                                        // 현재 위치에서 매장까지 거리를 소수점 1자리로 표시
                                        if let distance = storeDataManager.distanceFromUser(to: store) {
                                            Text(String(format: "%.1fkm", distance))
                                                .font(.mainTextMedium12)
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top)
                        }
                        Spacer()
                    }
                }
            }
            .navigationTitle("매장 설정")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isMapView.toggle()
                    }) {
                        Image(systemName: isMapView ? "list.bullet" : "map")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
    
    // 탭에 따라 보여줄 매장 필터링
    var filteredStores: [Store] {
        let baseStores: [Store]
        switch selectedTab {
        case .nearby:
            baseStores = storeDataManager.stores
        case .frequent:
            baseStores = storeDataManager.stores.filter { $0.name.contains("청담") || $0.name.contains("강남") }
        }
        
        return baseStores.sorted {
            let distance1 = storeDataManager.distanceFromUser(to: $0) ?? Double.greatestFiniteMagnitude
            let distance2 = storeDataManager.distanceFromUser(to: $1) ?? Double.greatestFiniteMagnitude
            return distance1 < distance2
        }
    }

    
    // 검색창 (읽기 전용)
    var searchBar: some View {
        TextField("검색", text: .constant(""))
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .padding()
    }

    var storeSegment: some View {
        return HStack(spacing: 16) {
            Button(action: {
                selectedTab = .nearby
            }) {
                Text("가까운 매장")
                    .font(.headline)
                    .foregroundColor(selectedTab == .nearby ? .green : .gray)
            }

            Button(action: {
                selectedTab = .frequent
            }) {
                Text("자주 가는 매장")
                    .font(.headline)
                    .foregroundColor(selectedTab == .frequent ? .green : .gray)
            }
        }
        .padding()
        
        Divider()
    }
    

}

#Preview {
    OrderSheetView()
}
