//
//  DetailMenuModel.swift
//  Starbucks
//
//  Created by nau on 4/3/25.
//

import Foundation
import SwiftUI

struct DetailMenuModel: Identifiable, Equatable, Hashable {
    var id: UUID = UUID()
    var image: ImageResource
    var menuName: String
    var menuNameEn: String
    var menuDescription: String
    var price: String
    var temperatures: [CoffeeTemperature]
}

enum CoffeeTemperature: String, CaseIterable {
    case hot = "HOT"
    case iced = "ICED"
    case hotonly = "HOT ONLY"
    case icedonly = "ICED ONLY"
}
