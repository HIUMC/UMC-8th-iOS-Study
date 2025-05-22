//
//  SearchLocationViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/19/25.
//

import Foundation

class SearchLocationViewModel: ObservableObject {
    @Published var startPoint: String = ""
    @Published var endPoint: String = ""
    @Published var storeList: [Store] = []
    @Published var startRoad: String = ""
    @Published var endRoad: String = ""
    
    @Published var selectedStartStore: Store? = nil // 목록 제거되니까 저장이 안 돼서

    func saveLocation() {
        // 기존 모델 기반 저장 로직 제거됨
    }

    func searchKeywordLocation(query: String) {
        print("🔍 키워드로 장소 검색 실행: \(query)")

        KakaoAPIService.shared.searchKeyword(query: query) { result in
            switch result {
            case .success(let response):
                print("📦 받은 documents 수: \(response.documents.count)")
                for doc in response.documents {
                    print("📍 \(doc.placeName), \(doc.roadAddressName)")
                }
                DispatchQueue.main.async {
                    self.storeList = response.documents.map {
                        Store(
                            placeName: $0.placeName,
                            roadAddressName: $0.roadAddressName,
                            x: $0.x, // 추가 (FiindMapView)
                            y: $0.y
                        )
                    }
                }
            case .failure(let error):
                print("❌ 검색 실패: \(error)")
            }
        }
    }
}
