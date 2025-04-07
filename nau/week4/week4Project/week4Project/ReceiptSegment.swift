//
//  ReceiptSegment.swift
//  week4Project
//
//  Created by nau on 4/7/25.
//

import Foundation

enum ReceiptSegment: Int, CaseIterable, Identifiable {
    case first
    case second
    
    var id: Int { rawValue } // id 값으로 각 case 식별
    
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
