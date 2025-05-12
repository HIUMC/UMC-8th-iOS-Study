//
//  BestItemsModel.swift
//  Starbucks
//
//  Created by 이가원 on 4/6/25.
//

import Foundation

struct BestItemModel: Identifiable,Hashable {
    let id = UUID()
    let imageName: String
    let title: String
}
