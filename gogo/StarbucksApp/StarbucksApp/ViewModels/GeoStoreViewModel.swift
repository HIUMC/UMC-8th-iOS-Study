//
//  GeoStoreViewModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/28/25.
//
//

import Foundation

class StarbucksGeoStoreViewModel: ObservableObject {
    @Published var keyword: String = ""
    @Published var starbucksStoreList: [StarbucksGeoStoreModel] = []
    @Published var endRoad: String = ""
    @Published var showNoResultAlert = false

    @Published var selectedEndStore: StarbucksGeoStoreModel? = nil
    
    func searchLocalStore(query: String) {
        print("📍 로컬 검색 시작: \(query)")

        guard let url = Bundle.main.url(forResource: "starbucks2025", withExtension: "geojson"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let features = json["features"] as? [[String: Any]] else {
            print("❌ geojson 로딩 실패")
            return
        }

        let matched = features.compactMap { feature -> StarbucksGeoStoreModel? in
            guard let props = feature["properties"] as? [String: Any],
                  let name = props["Sotre_nm"] as? String,
                  let addr = props["Address"] as? String else { return nil }

            if name.localizedCaseInsensitiveContains(query) || addr.localizedCaseInsensitiveContains(query) { //검색어가 들어간 매장 이름 또는 주소만 필터링
                if let geometry = feature["geometry"] as? [String: Any], // gpt
                   let coordinates = geometry["coordinates"] as? [Double],
                   coordinates.count >= 2 {
                    let x = String(coordinates[0])
                    let y = String(coordinates[1])
                    return StarbucksGeoStoreModel(name: name, address: addr, x: x, y: y)
                }
            }
            return nil
        }

        DispatchQueue.main.async {
            self.starbucksStoreList = matched
            self.showNoResultAlert = matched.isEmpty
        }
    }
}
