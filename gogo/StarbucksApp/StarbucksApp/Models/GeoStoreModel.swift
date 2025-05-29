//
//  GeoStoreModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 5/28/25.
//


import Foundation

struct StarbucksGeoStoreModel: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let x: String  // 경도
    let y: String  // 위도
}
