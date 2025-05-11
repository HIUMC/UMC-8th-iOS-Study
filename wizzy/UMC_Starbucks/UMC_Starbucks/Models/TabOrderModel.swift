//
//  TabOrderModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/1/25.
//

enum TabOrderItem: Int, CaseIterable, Identifiable {
    case allMenu, myMenu, cakeReserve
    
    var id: Int { self.rawValue }
    
    var title: String {
        switch self {
        case .allMenu: return "전체 메뉴"
        case .myMenu: return "나만의 메뉴"
        case .cakeReserve: return "홀케이크 예약"
        }
    }
}
