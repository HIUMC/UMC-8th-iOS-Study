//
//  CoffeeDetailModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/1/25.
//

import SwiftUI

struct CoffeeDetailModel: Hashable {
    let title: String
    let englishName: String
    let imageName: String
    let descrip: String
    let price: Int
    let temp: [Temp]
    
    enum Temp: String {
        case ice = "ICED ONLY"
        case hot = "HOT ONLY"
        
        
        func returnColor() -> Color {
            switch self {
            case .ice:
                return .blue01
            case .hot:
                return .red01
            }
        }
    }
    
}
