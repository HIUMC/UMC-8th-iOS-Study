//
//  ShopModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/8/25.
//
import Foundation

struct OnlineStoreModel: Hashable {
    let id = UUID()
    let imageName: String
}

struct AllProductModel: Hashable {
    let id = UUID()
    let imageName: String
    let title: String
}

struct ProductModel: Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    let cupSize: Int?
}

enum ProductPage: Int, CaseIterable, Identifiable {
    case first
    case second
    
    var id: Int { rawValue }
    
    func items(from array: [ProductModel], itemsPerPage: Int = 4) -> [ProductModel] {
        let start = rawValue * itemsPerPage
        let end = min(start + itemsPerPage, array.count)
        return Array(array[start..<end])
    }
}

