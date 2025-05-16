//
//  ShopViewModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/8/25.
//

import Foundation

@Observable
class ShopViewModel {
    var banners = [
        ShopBannerModel(img: "shopBanner01"),
        ShopBannerModel(img: "shopBanner02"),
        ShopBannerModel(img: "shopBanner03")
    ]
    
    var allProducts = [
        AllProductsModel(img: "shopAll01", name: "텀블러"),
        AllProductsModel(img: "shopAll02", name: "커피 용품"),
        AllProductsModel(img: "shopAll03", name: "선물세트"),
        AllProductsModel(img: "shopAll04", name: "보온병"),
        AllProductsModel(img: "shopAll05", name: "머그/컵"),
        AllProductsModel(img: "shopAll06", name: "라이프스타일")
    ]
    
    var bestItems = [
        [
            BestItemsModel(img: "homeBest01", name: "그린 사이렌 슬리브 머그 355ml"),
            BestItemsModel(img: "homeBest02", name: "그린 사이렌 클래식 머그 355ml"),
            BestItemsModel(img: "homeBest03", name: "사이렌 머그 앤 우드 소서"),
            BestItemsModel(img: "homeBest04", name: "리저브 골드 테일 머그 355ml"),
        ],
        [
            BestItemsModel(img: "homeBest05", name: "블랙 앤 골드 머그 473ml"),
            BestItemsModel(img: "homeBest06", name: "블랙 링 머그 355ml"),
            BestItemsModel(img: "homeBest07", name: "북청사자놀음 데미머그 89ml"),
            BestItemsModel(img: "homeBest08", name: "서울 제주 데미머그 세트")
        ]
    ]
    
    var newProducts = [
        NewProductsModel(img: "homeNew01", name: "그린 사이렌 도트 머그 237ml"),
        NewProductsModel(img: "homeNew02", name: "그린 사이렌 도트 머그 355ml"),
        NewProductsModel(img: "homeNew03", name: "홈 카페 미니 머그 세트"),
        NewProductsModel(img: "homeNew04", name: "홈 카페 글라스 세트")
    ]
}
