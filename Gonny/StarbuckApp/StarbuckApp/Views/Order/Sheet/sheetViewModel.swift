//
//  OrdersheetViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/29/25.
//

import Foundation
import MapKit
import CoreLocation

class OrderSheetViewModel: ObservableObject {
    @Published var stores: [StoreFeature] = []

    let parser = JSONParsingViewModel()

    func loadNearbyStores(userLocation: CLLocation) {
        parser.loadStoreData { result in
            switch result {
            case .success(let storeModel):
                // 매장 정보 중에서 가까운 것만 필터링
                let nearby = storeModel.features.filter {
                    let loc = CLLocation(latitude: $0.properties.yCoordinate,
                                         longitude: $0.properties.xCoordinate)
                    return userLocation.distance(from: loc) <= 10_000
                }

                DispatchQueue.main.async {
                    self.stores = nearby
                }

            case .failure(let error):
                print("매장 데이터 불러오기 실패: \(error)")
            }
        }
    }
}

