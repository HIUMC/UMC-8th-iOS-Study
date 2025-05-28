//
//  StarbucksGeoStoreModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/20/25.
//

// StarbucksGeoStore.swift
import Foundation

struct StarbucksGeoStoreModel: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let x: String  // 경도
    let y: String  // 위도
}
