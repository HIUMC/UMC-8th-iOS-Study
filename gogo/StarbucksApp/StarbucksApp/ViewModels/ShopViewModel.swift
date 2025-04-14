//
//  ShopViewModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/15/25.
//
import SwiftUI


class ShopViewModel: ObservableObject {
    // Banner 이미지 리스트 (실제 프로젝트에서는 받아온 URL이나 로컬 이미지 이름 사용)
    let bannerImages = ["variant1", "variant2", "variant3"]
    
    
    let allProducts: [ShopModel] = [
        ShopModel(name: "텀블러", imageName: "product1"),
        ShopModel(name: "커피 용품", imageName: "product2"),
        ShopModel(name: "선물세트", imageName: "product3"),
        ShopModel(name: "보온병", imageName: "product4"),
        ShopModel(name: "머그/컵", imageName: "product5"),
        ShopModel(name: "라이프스타일", imageName: "product6"),
    ]
    
    
    let bestItems: [ShopModel] = [
        ShopModel(name: "그린 사이렌 슬리브 머그\n355ml", imageName: "cup1"),
        ShopModel(name: "그린 사이렌 클래식 머그\n355ml", imageName: "cup2"),
        ShopModel(name: "사이렌 머그 앤 우드 소서", imageName: "cup3"),
        ShopModel(name: "리저브 골드 테일 머그\n355ml", imageName: "cup4"),
        ShopModel(name: "리저브 골드 테일 머그\n355ml", imageName: "cup5"),
        ShopModel(name: "리저브 골드 테일 머그\n355ml", imageName: "cup6"),
        ShopModel(name: "리저브 골드 테일 머그\n355ml", imageName: "cup7"),
        ShopModel(name: "리저브 골드 테일 머그\n355ml", imageName: "cup8")
    ]
    
    
    @Published var currentBestPage: Int = 0
    
    var totalBestPages: Int {
        let itemsPerPage = 4
        return Int(ceil(Double(bestItems.count) / Double(itemsPerPage)))
    }
    
    func bestItemsForPage(_ pageIndex: Int) -> [ShopModel] {
        let start = pageIndex * 4
        let end = min(start + 4, bestItems.count)
        return Array(bestItems[start..<end])
    }
    // New Products 더미 데이터 (4개라고 가정)
    let newProducts: [ShopModel] = [
        ShopModel(name: "그린 사이렌 도트 머그\n237ml", imageName: "new1"),
        ShopModel(name: "그린 사이렌 도트 머그\n355ml", imageName: "new2"),
        ShopModel(name: "홈 카페 미니 머그 세트", imageName: "new3"),
        ShopModel(name: "홈 카페 글라스 세트", imageName: "new4")
    ]
    
 
}
