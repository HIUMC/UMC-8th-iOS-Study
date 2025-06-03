//
//  OrderModel.swift
//  Starbucks
//
//  Created by 김영택 on 5/2/25.
//

import Foundation

struct OrderModel: Identifiable, Hashable {
    var id = UUID()
    var imageName: String
    var title: String
    var englishTitle: String
}
