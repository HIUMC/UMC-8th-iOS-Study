//
//  StoreModel.swift
//  Starbucks
//
//  Created by 박정환 on 5/2/25.
//

import Foundation

enum OrderSheetSegment: Int, CaseIterable, Identifiable {
    case first
    case second
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .first:
            return "가까운 매장"
        case .second:
            return "자주 가는 매장"
        }
    }
}
