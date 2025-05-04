//
//  BestViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/5/25.
//

import Foundation
class BestViewModel: ObservableObject  {
    var Bestname : [best] = [
        best(imageName: "best1", title: "그린 사이렌 슬리브 머그 355ml"),
        best(imageName: "best2", title: "그린 사이렌 클래식 머그 355ml"),
        best(imageName: "best3", title: "사이렌 머그 앤 우드 소서"),
        best(imageName: "best4", title: "리저브 골드 테일 머그 355ml"),
        best(imageName: "best5", title: "블랙 앤 골드 머그 473 ml"),
        best(imageName: "best6", title: "블랙 링 머그 355ml"),
        best(imageName: "best7", title: "북청사자놀음 데미머그 89ml"),
        best(imageName: "best8", title: "서울 제주 데미머그 세트")
    ]
}
