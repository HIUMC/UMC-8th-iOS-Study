//
//  DessertViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import Foundation
import SwiftUI

class DessertViewModel: ObservableObject {
    var DessertList: [DessertModel] = [
        DessertModel(dessertName: "너티 크루아상", imageName: "d1"),
        DessertModel(dessertName: "매콤 소시지 불고기", imageName: "d2"),
        DessertModel(dessertName: "미니 리프 파이", imageName: "d3"),
        DessertModel(dessertName: "뺑 오 쇼콜라", imageName: "d4"),
        DessertModel(dessertName: "소시지&올리브 파이", imageName: "d5")
    ]
    
}
