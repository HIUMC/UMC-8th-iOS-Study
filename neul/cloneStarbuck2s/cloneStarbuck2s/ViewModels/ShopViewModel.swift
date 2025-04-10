//
//  ShopViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/8/25.
//
import SwiftUI

@Observable
class ShopViewModel {
    var selectedPage: Int = 0 
    
    
    var onlineStores: [OnlineStoreModel] = [
        OnlineStoreModel(imageName: "banner1"),
        OnlineStoreModel(imageName: "banner2"),
        OnlineStoreModel(imageName: "banner3")
    ]
    
    var allProducts: [AllProductModel] = [
        AllProductModel(imageName: "ap1", title: "텀블러"),
        AllProductModel(imageName: "ap2", title: "커피 용품"),
        AllProductModel(imageName: "ap3", title: "선물세트"),
        AllProductModel(imageName: "ap4", title: "보온병"),
        AllProductModel(imageName: "ap5", title: "머그/컵"),
        AllProductModel(imageName: "ap6", title: "라이프스타일")
    ]
    
    var bestItems: [ProductModel] = [
        ProductModel(imageName: "best1", title: "그린 사이렌 슬리브 머그", cupSize: 355),
        ProductModel(imageName: "best2", title: "그린 사이렌 클래식 머그", cupSize: 355),
        ProductModel(imageName: "best3", title: "사이렌 머그 앤 우드 소서", cupSize: nil),
        ProductModel(imageName: "best4", title: "리저브 골드 테일 머그", cupSize: 355),
        ProductModel(imageName: "best5", title: "블랙 앤 골드 머그", cupSize: 473),
        ProductModel(imageName: "best6", title: "블랙 링 머그", cupSize: 355),
        ProductModel(imageName: "best7", title: "북청사자놀음 데미머그", cupSize: 89),
        ProductModel(imageName: "best8", title: "서울 제주 데미머그 세트", cupSize: nil)
    ]
    
    var newProducts: [ProductModel] = [
        ProductModel(imageName: "np1", title: "그린 사이렌 도트 머그", cupSize: 237),
        ProductModel(imageName: "np2", title: "그린 사이렌 도트 머그", cupSize: 355),
        ProductModel(imageName: "np3", title: "홈 카페 미니 머그 세트", cupSize: nil),
        ProductModel(imageName: "np4", title: "홈 카페 글라스 세트", cupSize: nil)
    ]
    
    
}
