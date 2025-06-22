//
//  BestItemModel.swift
//  Starbucks
//
//  Created by 이가원 on 4/6/25.
//


import Foundation

class BestItemsViewModel: ObservableObject {
    @Published var bestItems: [BestItemModel] = [
        BestItemModel(imageName: "mug1", title: "그린 사이렌 슬리브 머그\n355ml"),
        BestItemModel(imageName: "mug2", title: "그린 사이렌 클래식 머그\n355ml"),
        BestItemModel(imageName: "mug3", title: "사이렌 머그 앤 우드 소서"),
        BestItemModel(imageName: "mug4", title: "리저브 골드 테일 머그\n355ml"),
        BestItemModel(imageName: "mug5", title: "블랙 엔 골드 머그 473ml"),
        BestItemModel(imageName: "mug6", title: "블랙 링 머그 355ml"),
        BestItemModel(imageName: "mug7", title: "북청사자놀음 데미머그\n89ml"),
        BestItemModel(imageName: "mug8", title: "서울 제주 데미머그 세ㅌ")
    ]
    
    func pagedItems(pageSize: Int = 4) -> [[BestItemModel]] {
        var result: [[BestItemModel]] = []
        var currentPage: [BestItemModel] = []

        for item in bestItems {
            currentPage.append(item)
            if currentPage.count == pageSize {
                result.append(currentPage)
                currentPage = []
            }
        }

        if !currentPage.isEmpty {
            result.append(currentPage)
        }

        return result
    }
}
