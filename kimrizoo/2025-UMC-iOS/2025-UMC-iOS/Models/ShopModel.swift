//
//  ShopModel.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/9/25.
//

import Foundation

struct AllProductCategoryModel: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
}

struct BestItemModel: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let subtitle: String
}
