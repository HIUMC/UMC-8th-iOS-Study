//
//  OrdersheetViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/29/25.
//

import Foundation
import MapKit
import CoreLocation
//반경 10km 이내에 있는 매장들만 필터링해서 stores배열에 저장
class OrderSheetViewModel: ObservableObject {//스유의 뷰에서 이 ViewModel을 관찰할 수 있게 해줌
    @Published var stores: [StoreFeature] = []//필터링 된 매장 정보 배열, @Published 속성을 통해 이 값이 바뀌면 뷰 자동 업데이트

    let parser = JSONParsingViewModel()//JSON 데이터를 파싱하는 역할을 담당하는 다른 뷰모델의 인스턴스, loadStoreData()를 통해 JSON파일에서 매장 정보를 가지고 옴

    func loadNearbyStores(userLocation: CLLocation) {//사용자의 위치를 받아 가까운 매장을 가지고 오는 함수, View에서 호출하면 stores값 업데이트
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
                }//UI업데이트는 반드시 메인 스레드에서 해야하므로 DispatchQueue로 감싸는 것

            case .failure(let error):
                print("매장 데이터 불러오기 실패: \(error)")
            }
        }
    }
}

