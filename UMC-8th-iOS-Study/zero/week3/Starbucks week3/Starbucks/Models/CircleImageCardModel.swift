//
//  CardModel.swift
//  Starbucks
//
//  Created by 김영택 on 4/6/25.
//

import Foundation

struct CoffeeCard: Identifiable, Hashable {
    let id = UUID()
    var cimageName : String
    var cmenuName : String
}

struct BreadCard: Identifiable, Hashable {
    let id = UUID()
    var bimageName : String
    var bmenuName : String
}
