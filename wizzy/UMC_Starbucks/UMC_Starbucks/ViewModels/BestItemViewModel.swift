//
//  BestItemViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/7/25.
//

import Foundation

class BestItemsViewModel: ObservableObject {
    @Published var pages: [[BestItemModel]] = []
    @Published var currentPage: Int = 0
    
    let bestItemList1: [BestItemModel] = [
        BestItemModel(imageName: "img1", itemTitle: "그린 사이렌 슬리브 머그", size: "355ml"),
        BestItemModel(imageName: "img2", itemTitle: "그린 사이렌 클래식 머그", size: "355ml"),
        BestItemModel(imageName: "img3", itemTitle: "사이렌 머그 앤 우드 소서", size: ""),
        BestItemModel(imageName: "img4", itemTitle: "리저브 골드 테일 머그", size: "355ml")
    ]
    
    
    let bestItemList2: [BestItemModel] = [
        BestItemModel(imageName: "img5", itemTitle: "블랙 앤 골드 머그", size: "355ml"),
        BestItemModel(imageName: "img6", itemTitle: "블랙 링 머그", size: "355ml"),
        BestItemModel(imageName: "img7", itemTitle: "북청사자놀음 데미머그", size: "89ml"),
        BestItemModel(imageName: "img8", itemTitle: "리저브 골드 테일 머그", size: "355ml")
    ]
    
    init() {
            pages = [bestItemList1, bestItemList2]
        }
}


