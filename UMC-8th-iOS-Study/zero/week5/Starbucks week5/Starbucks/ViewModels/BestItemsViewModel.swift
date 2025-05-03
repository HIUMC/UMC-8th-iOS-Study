//
//  BestItemsViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 4/10/25.
//

import Foundation

class BestItemsViewModel: ObservableObject {
    
    @Published var bestitems: [BestItemsModel] = [
        BestItemsModel(bestItemsImageName: "bestItem1", bestItemsName: "그린 사이렌 슬리브 머그\n355ml"),
        BestItemsModel(bestItemsImageName: "bestItem2", bestItemsName: "그린 사이렌 클래식 머그\n355ml"),
        BestItemsModel(bestItemsImageName: "bestItem3", bestItemsName: "사이렌 머그 앤 우드 소서"),
        BestItemsModel(bestItemsImageName: "bestItem4", bestItemsName: "리저브 골드 테일 머그\n355ml"),
        BestItemsModel(bestItemsImageName: "bestItem5", bestItemsName: "블랙 앤 골드 머그 473ml"),
        BestItemsModel(bestItemsImageName: "bestItem6", bestItemsName: "블랙 링 머그 355ml"),
        BestItemsModel(bestItemsImageName: "bestItem7", bestItemsName: "북청사자놀음 데미머그\n89ml"),
        BestItemsModel(bestItemsImageName: "bestItem8", bestItemsName: "서울 제주 데미머그 세트"),
    ]
}
