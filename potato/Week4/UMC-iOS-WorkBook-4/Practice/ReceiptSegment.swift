//
//  ReceiptSegment.swift
//  UMC-iOS-WorkBook-4
//
//  Created by 곽은채 on 4/7/25.
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
            return "first"
        case .second:
            return "second"
        }
    }
}
