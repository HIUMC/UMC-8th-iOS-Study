//
//  ReciptsSegment.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/13/25.
//

import Foundation

enum ReceiptSegment: Int, CaseIterable {
    case first
    case second
    

    
    var title: String {
        switch self {
        case .first:
            return "첫 번째"
        case .second:
            return "두 번째"
        }
    }
    
    var imageName: String {
        switch self {
        case .first:
            return "first"
        case .second:
            return "second"
        }
    }
}
