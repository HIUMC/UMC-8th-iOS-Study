//
//  ShopModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/7/25.
//
import Foundation

struct ProductItem: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let imageName: String
}

