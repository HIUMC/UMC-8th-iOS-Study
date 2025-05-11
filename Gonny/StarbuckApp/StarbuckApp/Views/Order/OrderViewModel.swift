//
//  Untitled.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/29/25.
//
import Foundation
import SwiftUI

enum TopSegment: String, CaseIterable {
    case allMenu = "전체 메뉴"
    case myyMenu = "나만의 메뉴"
    case cakeReservation = "홀케이크 예약"
}

enum BottomSegment: String, CaseIterable {
    case drink = "음료"
    case food = "푸드"
    case product = "상품"
}

@MainActor
class OrderViewModel: ObservableObject {
    @Published var selectedTopSegment: TopSegment = .allMenu
    @Published var selectedBottomSegment: BottomSegment = .drink
    @Published var showStoreSheet: Bool = false

    @Published var orderCoffeeItems: [OrderCoffeeItem] = [
        OrderCoffeeItem(name: "추천", description: "Recommend", imageName: "recommend"),
        OrderCoffeeItem(name: "아이스 카페 아메리카노", description: "Reserve Espresso", imageName: "coffee2"),
        OrderCoffeeItem(name: "카페 아메리카노", description: "Reserve Drip", imageName: "coffee3"),
        OrderCoffeeItem(name: "카푸치노", description: "Decaf Coffee", imageName: "Capuccino"),
        OrderCoffeeItem(name: "아이스 카푸치노", description: "Espresso", imageName: "icedCapuccino"),
        OrderCoffeeItem(name: "카라멜 마키아또", description: "Blonde Coffee", imageName: "coffee6"),
        OrderCoffeeItem(name: "아이스 카라멜 마키아또", description: "Cold Brew", imageName: "coffee7"),
        OrderCoffeeItem(name: "아포가토/기타", description: "Others", imageName: "apogato"),
        OrderCoffeeItem(name: "럼 샷 코르타도", description: "Brewed Coffee", imageName: "cortado"),
        OrderCoffeeItem(name: "라벤더 카페 브레베", description: "Teavana", imageName: "breve"),
        OrderCoffeeItem(name: "병음료", description: "RTD", imageName: "bottleDrink")
    ]
}
