//
//  StoreModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/20/25.
//

import Foundation

struct Store: Identifiable {
    let id = UUID()               
    let placeName: String
    let roadAddressName: String
    let x: String  // 경도
    let y: String  // 위도
}
