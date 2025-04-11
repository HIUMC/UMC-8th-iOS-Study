//
//  ShopViewModel.swift
//  Starbucks
//
//  Created by 박정환 on 4/7/25.
//

import Foundation
import SwiftUI
import Observation

@Observable
class ShopViewModel {    
    let dummyProducts: [ItemModel] = [
        ItemModel(image: Image("product1"), title: "텀블러"),
        ItemModel(image: Image("product2"), title: "커피 용품"),
        ItemModel(image: Image("product3"), title: "선물세트"),
        ItemModel(image: Image("product4"), title: "보온병"),
        ItemModel(image: Image("product5"), title: "머그/컵"),
        ItemModel(image: Image("product6"), title: "라이프스타일"),
    ]
    
    let dummyBestItems: [ItemModel] = [
        ItemModel(image: Image("item1"), title: "그린 사이렌 슬리브 머그\n355ml"),
        ItemModel(image: Image("item2"), title: "그린 사이렌 클래식 머그\n355ml"),
        ItemModel(image: Image("item3"), title: "사이렌 머그 앤 우드 소서"),
        ItemModel(image: Image("item4"), title: "리저브 골드 테일 머그\n355ml"),
        ItemModel(image: Image("item5"), title: "블랙 앤 골드 머그 473ml"),
        ItemModel(image: Image("item6"), title: "블랙 링 머그 355ml"),
        ItemModel(image: Image("item7"), title: "북청사자놀음 데미머그\n89ml"),
        ItemModel(image: Image("item8"), title: "서울 제주 데미머그 세트")
    ]
    
    let dummyNewProducts: [ItemModel] = [
        ItemModel(image: Image("newProduct1"), title: "그린 사이렌 도트 머그\n237ml"),
        ItemModel(image: Image("newProduct2"), title: "그린 사이렌 도트 머그\n355ml"),
        ItemModel(image: Image("newProduct3"), title: "홈 카페 미니 머그 세트"),
        ItemModel(image: Image("newProduct4"), title: "홈 카페 글라스 세트")
    ]
}
