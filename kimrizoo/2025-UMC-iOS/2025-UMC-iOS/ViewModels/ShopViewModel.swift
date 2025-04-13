//
//  ShopViewModel.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/9/25.
//

import Foundation
import SwiftUI

@Observable
class ShopViewModel {

    var allCategories: [AllProductCategoryModel] = [
        AllProductCategoryModel(imageName: "all_products1", title: "텀블러"),
        AllProductCategoryModel(imageName: "all_products2", title: "커피 용품"),
        AllProductCategoryModel(imageName: "all_products3", title: "선물세트"),
        AllProductCategoryModel(imageName: "all_products4", title: "보온병"),
        AllProductCategoryModel(imageName: "all_products5", title: "머그/컵"),
        AllProductCategoryModel(imageName: "all_products6", title: "라이프스타일")
    ]

    var bestItems: [BestItemModel] = [
        BestItemModel(imageName: "best1", title: "그린 사이렌 슬리브 머그", subtitle: "355ml"),
        BestItemModel(imageName: "best2", title: "그린 사이렌 클래식 머그", subtitle: "355ml"),
        BestItemModel(imageName: "best3", title: "사이렌 머그 앤 우드 소서", subtitle: ""),
        BestItemModel(imageName: "best4", title: "리저브 골드 테일 머그", subtitle: "355ml"),
        BestItemModel(imageName: "best5", title: "블랙 앤 골드 머그", subtitle: "473ml"),
        BestItemModel(imageName: "best6", title: "블랙 링 머그", subtitle: "355ml"),
        BestItemModel(imageName: "best7", title: "북청사자놀음 데미머그", subtitle: "89ml"),
        BestItemModel(imageName: "best8", title: "서울 제주 데미머그 세트", subtitle: "")
    ]

    var newProducts: [BestItemModel] = [
        BestItemModel(imageName: "new1", title: "그린 사이렌 도트 머그", subtitle: "237ml"),
        BestItemModel(imageName: "new2", title: "그린 사이렌 도트 머그", subtitle: "355ml"),
        BestItemModel(imageName: "new3", title: "홈 카페 미니 머그 세트", subtitle: ""),
        BestItemModel(imageName: "new4", title: "홈 카페 글라스 세트", subtitle: "")
    ]
}
