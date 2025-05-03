//
//  OrderModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/28/25.
//
import SwiftUI

enum OrderSegment: String, CaseIterable {
    case allMenu = "전체 메뉴"
    case myMenu = "나만의 메뉴"
    case reserveCake = "홀케이크 예약"
    
    var textColor: Color {
        switch self {
        case .reserveCake:
            return .green01
        default:
            return .gray04
        }
    }
}


struct DrinkModel: Hashable {
    let id = UUID()
    let title: String
    let imageName: String
    let descrip: String
}


