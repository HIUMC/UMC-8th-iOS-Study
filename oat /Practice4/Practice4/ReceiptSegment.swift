//
//  ReceiptSegment..swift
//  Practice4
//
//  Created by 신민정 on 4/3/25.
//
// 첫번째, 두번재 영수증을 보이도록하기 위해 
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

