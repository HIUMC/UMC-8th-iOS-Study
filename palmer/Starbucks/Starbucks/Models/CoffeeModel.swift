//
//  CoffeeModel.swift
//  Starbucks
//
//  Created by 박정환 on 4/2/25.
//

import SwiftUI

struct CoffeeModel: Identifiable {
    let id = UUID()
    var name: String
    var nameEn: String
    var image: Image
    var content: String
    var price: String
    var temperature: Temp
    var hasBothTemps: Bool

    
    enum Temp: String, CaseIterable {
        case iced = "ICED"
        case hot = "HOT"
    }
}
