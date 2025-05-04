//
//  ShopViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/7/25.
//

import Foundation
import SwiftUI

class ShopViewModel: ObservableObject {
    @Published var allItems:[ProductItem]=[
        ProductItem(name:"텀블러", description: "", imageName: "allitem1"),
        ProductItem(name:"커피 용품", description: "", imageName: "allitem2"),
        ProductItem(name:"선물세트", description: "", imageName: "allitem3"),
        ProductItem(name:"보온병", description: "", imageName: "allitem4"),
        ProductItem(name:"머그컵", description: "", imageName: "allitem5"),
        ProductItem(name:"라이프스타일", description: "", imageName: "allitem6")
    ]
    @Published var bestItems: [ProductItem] = [
        ProductItem(name: "그린 사이렌 슬리브 머그", description: "355ml", imageName: "bestitem1"),
        ProductItem(name: "그린 사이렌 클래식 머그", description: "355ml", imageName: "bestitem2"),
        ProductItem(name: "사이렌 머그 앤 우드 소서", description: "", imageName: "bestitem3"),
        ProductItem(name: "리저브 골드 테일 머그", description: "355ml", imageName: "bestitem4"),
        ProductItem(name: "블랙 앤 골드 머그", description: "473ml", imageName: "bestitem5"),
        ProductItem(name: "블랙 링 머그", description: "335ml", imageName: "bestitem6"),
        ProductItem(name: "북청사자올음 데미머그", description: "89ml", imageName: "bestitem7"),
        ProductItem(name: "서울 제주 데미머그 세트", description: "", imageName: "bestitem8")
    ]

    @Published var newProducts: [ProductItem] = [
        ProductItem(name: "그린 사이렌 토트 머그", description: "237ml", imageName: "NewProduct1"),
        ProductItem(name: "그린 사이렌 토트 머그", description: "355ml", imageName: "NewProduct2"),
        ProductItem(name: "홈 카페 미니 머그 세트", description: "", imageName: "NewProduct3"),
        ProductItem(name: "홈 카페 글라스 세트", description: "", imageName: "NewProduc4")
    ]
}
