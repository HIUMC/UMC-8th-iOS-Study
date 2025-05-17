//
//  OrderViewModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/29/25.
//

import Foundation

@Observable
class OrderViewModel {
    var coffees = [
        OrderCoffeeModel(img: "macchiato", name: "추천", nameEng: "Recommend"),
        OrderCoffeeModel(img: "iceAmericano", name: "아이스 카페 아메리카노", nameEng: "Reserve Espresso"),
        OrderCoffeeModel(img: "americano", name: "카페 아메리카노", nameEng: "Reserve Drip"),
        OrderCoffeeModel(img: "cappuccino", name: "카푸치노", nameEng: "Dcaf Coffee"),
        OrderCoffeeModel(img: "iceCappuccino", name: "아이스 카푸치노", nameEng: "Espresso"),
        OrderCoffeeModel(img: "caramel", name: "카라멜 마키아또", nameEng: "Blonde Coffee"),
        OrderCoffeeModel(img: "iceCaramel", name: "아이스 카라멜 마키아또", nameEng: "Cold Brew"),
        OrderCoffeeModel(img: "affogato", name: "아포가토/기타", nameEng: "Others"),
        OrderCoffeeModel(img: "brewedCoffee", name: "럼 샷 코르타도", nameEng: "Brewed Coffee"),
        OrderCoffeeModel(img: "teavana", name: "라벤터 카페 브레베", nameEng: "Teavana"),
        OrderCoffeeModel(img: "bottle", name: "병음료", nameEng: "RTD"),
    ]
}

enum OrderTabOptions: Int, CaseIterable, Identifiable {
    case allMenu
    case myMenu
    case reserveCake
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .allMenu:
            return "전체 메뉴"
        case .myMenu:
            return "나만의 메뉴"
        case .reserveCake:
            return "홀케이크 예약"
        }
    }
}

enum AllTabOptions: Int, CaseIterable, Identifiable {
    case drink
    case food
    case product
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .drink:
            return "음료"
        case .food:
            return "푸드"
        case .product:
            return "상품"
        }
    }
}

enum StoreType: Int, CaseIterable, Identifiable {
    case near
    case often
    
    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .near:
            return "가까운 매장"
        case .often:
            return "자주 가는 매장"
        }
    }
}
