//
//  DessertModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/1/25.
//
import Foundation

struct DessertModel: Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    
    static let dummy = [
        DessertModel(imageName: "b1", title: "너티 크루아상"),
        DessertModel(imageName: "b2", title: "매콤 소시지 불고기"),
        DessertModel(imageName: "b3", title: "미니 리프 파이"),
        DessertModel(imageName: "b4", title: "뺑 오 쇼콜라"),
        DessertModel(imageName: "b5", title: "소시지 & 올리브 파이")
    ]
}
