//
//  WhatsNewModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/1/25.
//

import Foundation

enum WhatsNewModel: CaseIterable {
    case campaine
    case store
    case reserve
    
    var id : UUID {
        switch self {
        case .campaine:
            return UUID()
        case .store:
            return UUID()
        case .reserve:
            return UUID()
        }
    }
    
    func returnNewImg() -> String {
        switch self {
        case .campaine:
            return "homeCampaine"
        case .store:
            return "homeStore"
        case .reserve:
            return "homeReserve"
        }
    }
    
    func returnNewName() -> String {
        switch self {
        case .campaine:
            return "25년 3월 일회용컵 없는 날 캠페인"
        case .store:
            return "스타벅스 ooo점을 찾습니다"
        case .reserve:
            return "2월 8일, 리저브 스프링 신규 커피 출시"
        }
    }
    
    func returnNewDetail() -> String {
        switch self {
        case .campaine:
            return "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요."
        case .store:
            return "스타벅스 커뮤니티 스토어 파트너를 웅영할 기관을 공모합니다."
        case .reserve:
            return "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요."
        }
    }
}
