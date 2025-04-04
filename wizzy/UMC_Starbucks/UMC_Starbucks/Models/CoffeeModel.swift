//
//  CoffeeModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import Foundation
import SwiftUI

struct CoffeeModel: Identifiable {
    var id = UUID()
    let title: String
    let engTitle: String
    let content: String
    let price: String // "4,100"
    let choice: CoffeeType
    let image: String
    let imageD: String

}


enum CoffeeType: String {
    case hot = "HOT"
    case iced = "ICED"
    case both = "HOT / ICED"
    
    
    var type: String {
        switch self {
        case .hot:
            return "HOT ONLY"
        case .iced:
            return "ICED ONLY"
        case .both:
            return "HOT / ICED"
        }
        
        
        var color: Color {
            switch self {
            case .hot:
                return .red01
            case .iced:
                return .blue01
            case .both:
                return .black03
            }
        }
        
        
    }
    
}
