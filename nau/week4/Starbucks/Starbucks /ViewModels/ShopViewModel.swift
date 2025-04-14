//
//  ShopViewModel.swift
//  Starbucks
//
//  Created by nau on 4/7/25.
//

import Foundation
import SwiftUI

@Observable
class ShopViewModel {
    var shopBannerViewModel = [
        ShopBannerModel(image: .banner1),
        ShopBannerModel(image: .banner2),
        ShopBannerModel(image: .banner3)
    ]
    
    var allProductsViewModel = [
        //HomeView에서 썼던 모델 재활용
        RecommendMenuModel(image: .allProduct1, name: "텀블러"),
        RecommendMenuModel(image: .allProduct2, name: "커피 용품"),
        RecommendMenuModel(image: .allProduct3, name: "선물세트"),
        RecommendMenuModel(image: .allProduct4, name: "보온병"),
        RecommendMenuModel(image: .allProduct5, name: "머그컵"),
        RecommendMenuModel(image: .allProduct6, name: "라이프스타일")
    ]
    
    var bestItemViewModel = [
        RecommendMenuModel(image: .cup1, name: "그린 사이렌 슬리브 머그 355ml"),
        RecommendMenuModel(image: .cup2, name: "그린 사이렌 클래식 머그 355ml"),
        RecommendMenuModel(image: .cup3, name: "사이렌 머그 앤 우드 소서"),
        RecommendMenuModel(image: .cup4, name: "리저브 골드 테일 머그 355ml"),
        RecommendMenuModel(image: .cup5, name: "블랙 앤 골드 머그 473ml"),
        RecommendMenuModel(image: .cup5, name: "블랙 링 머그 355ml"),
        RecommendMenuModel(image: .cup6, name: "북청사자놀음 데미머그 89ml"),
        RecommendMenuModel(image: .cup7, name: "서울 제주 데미머그 세트"),
    ]
    
    var newProductViewModel = [
        RecommendMenuModel(image: .new1, name: "그린 사이렌 도트 머그 237ml"),
        RecommendMenuModel(image: .new2, name: "그린 사이렌 도트 머그 355ml"),
        RecommendMenuModel(image: .new3, name: "홈 카페 미니 머그 세트"),
        RecommendMenuModel(image: .new4, name: "홈 카페 글라스 세트"),
    ]
}
