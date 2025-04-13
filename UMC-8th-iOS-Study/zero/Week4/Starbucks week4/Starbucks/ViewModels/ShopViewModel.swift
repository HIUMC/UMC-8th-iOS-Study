//
//  ShopViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 4/10/25.
//

import Foundation

class ShopViewModel: ObservableObject {
    
    @Published var onlinestores: [ShopModel] = [
        ShopModel(oimageName: "onlineStore1"),
        ShopModel(oimageName: "onlineStore2"),
        ShopModel(oimageName: "onlineStore3")
    ]
    
    @Published var allproduct: [ProductCard] = [
        ProductCard(allProductimageName: "allProduct1", allProductName: "텀블러"),
        ProductCard(allProductimageName: "allProduct2", allProductName: "커피 용품"),
        ProductCard(allProductimageName: "allProduct3", allProductName: "선물세트"),
        ProductCard(allProductimageName: "allProduct4", allProductName: "보온병"),
        ProductCard(allProductimageName: "allProduct5", allProductName: "머그/컵"),
        ProductCard(allProductimageName: "allProduct6", allProductName: "라이프스타일")
    ]
}
