//
//  CoffeeDetailModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/1/25.
//

import SwiftUI

struct CoffeeDetailModel {
    let title: String
    let englishName: String
    let descrip: String
    let price: Int
    let temp: Temp
    
    
    enum Temp: String, CaseIterable {
        case ice = "ICED"
        case hot = "HOT"
        
        var color: Color {
            switch self {
            case .ice:
                return .red01
            case .hot:
                return Color.blue.opacity(0.63)
            }
        }
    }
}
