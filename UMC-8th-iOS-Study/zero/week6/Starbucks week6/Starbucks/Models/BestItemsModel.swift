//
//  BestItemsModel.swift
//  Starbucks
//
//  Created by 김영택 on 4/10/25.
//
import Foundation

struct BestItemsModel: Identifiable, Hashable {
    let id = UUID()
    var bestItemsImageName : String
    var bestItemsName : String
}
