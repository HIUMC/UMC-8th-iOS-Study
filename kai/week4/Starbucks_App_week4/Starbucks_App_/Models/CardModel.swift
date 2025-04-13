//
//  CoffeeCardModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/7/25.
//

import Foundation


struct CardModel: Identifiable, Hashable {
    let id = UUID()
    var imageName: String
    var title: String
}
