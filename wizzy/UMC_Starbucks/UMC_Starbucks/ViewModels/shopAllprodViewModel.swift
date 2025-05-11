//
//  shopAllprodViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/6/25.
//

import Foundation
import SwiftUI

class ShopAllprodViewModel: ObservableObject {
    var shopAllprodList: [ShopAllprodModel] = [
        ShopAllprodModel(prodName: "텀블러", imageName: "prod1"),
        ShopAllprodModel(prodName: "커피 용품", imageName: "prod2"),
        ShopAllprodModel(prodName: "선물세트", imageName: "prod3"),
        ShopAllprodModel(prodName: "보온병", imageName: "prod4"),
        ShopAllprodModel(prodName: "머그/컵", imageName: "prod5"),
        ShopAllprodModel(prodName: "라이프스타일", imageName: "prod6")
    ]
    
}
