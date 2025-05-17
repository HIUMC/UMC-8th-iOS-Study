//
//  ReceiptSegment.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/8/25.
//

//
//  ReceiptSegment.swift
//  4st_Practice
//
//  Created by 이서현 on 4/6/25.
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


/*
import Foundation
struct ReceiptSegment: Identifiable {
    let id = UUID()
    var title: String
    var imageName: String
}
*/
