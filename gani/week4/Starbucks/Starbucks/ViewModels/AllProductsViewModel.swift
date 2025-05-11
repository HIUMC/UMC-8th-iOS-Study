//
//  AllProductsViewModel.swift
//  Starbucks
//
//  Created by 이가원 on 4/6/25.
//

import SwiftUI
import Foundation
class AllProductsViewModel: ObservableObject {
    @Published var products: [AllProducts] = [
        AllProducts(id: UUID(), name: "텀블러", imageName: "pro1"),
        AllProducts(id: UUID(), name: "커피 용품", imageName: "pro2"),
        AllProducts(id: UUID(), name: "선물세트", imageName: "pro3"),
        AllProducts(id: UUID(), name: "보온병", imageName: "pro4"),
        AllProducts(id: UUID(), name: "머그/컵", imageName: "pro5"),
        AllProducts(id: UUID(), name: "라이프스타일", imageName: "pro6")
    ]
}
