//
//  RecommendModel.swift
//  Starbucks
//
//  Created by 박정환 on 4/2/25.
//

import Foundation
import SwiftUI

struct RecommendModel: Identifiable,  {
    let id = UUID()
    var name: String
    var nameEn: String
    var image: Image
    var content: String
    var price: String
    var temperature: CoffeeTemp
    var hasBothTemps: Bool
}

enum CoffeeTemp: CaseIterable {
    case hot
    case iced
}
