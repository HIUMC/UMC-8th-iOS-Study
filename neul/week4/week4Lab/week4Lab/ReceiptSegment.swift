//
//  ReceiptSegment.swift
//  week4Lab
//
//  Created by tokkislove on 4/7/25.
//

import Foundation

enum ReceiptSegment: Int, CaseIterable, Identifiable {
    case first
    case second
    
    var id: Int { rawValue }
    
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
            return "r1"
        case .second:
            return "r2"
        }
    }
}
