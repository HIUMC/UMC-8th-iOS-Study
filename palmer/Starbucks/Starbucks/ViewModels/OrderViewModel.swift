//
//  OrderViewModel.swift
//  Starbucks
//
//  Created by 박정환 on 5/5/25.
//

import SwiftUI

@Observable
class OrderViewModel {
    var selectedTopSegment: OrderSegment = .first
    var selectedBottomSegment: CategorySegment = .first
    
    let dummyOrderList: [OrderCoffeeModel] = [
        OrderCoffeeModel(image: "orderList1", name: "추천", nameEn: "Recommend"),
        OrderCoffeeModel(image: "orderList2", name: "아이스 카페 아메리카노", nameEn: "Reserve Espresso"),
        OrderCoffeeModel(image: "orderList3", name: "카페 아메리카노", nameEn: "Reserve Drip"),
        OrderCoffeeModel(image: "orderList4", name: "카푸치노", nameEn: "Dcaf Coffee"),
        OrderCoffeeModel(image: "orderList5", name: "아이스 카푸치노", nameEn: "Espresso"),
        OrderCoffeeModel(image: "orderList6", name: "카라멜 마키아또", nameEn: "Blonde Coffee"),
        OrderCoffeeModel(image: "orderList7", name: "아이스 카라멜 마키아또", nameEn: "Cold Brew"),
        OrderCoffeeModel(image: "orderList8", name: "아포가토/기타", nameEn: "Others"),
        OrderCoffeeModel(image: "orderList9", name: "럼 샷 코르타도", nameEn: "Brewed Coffee"),
        OrderCoffeeModel(image: "orderList10", name: "라벤더 카페 브레베", nameEn: "Teavana"),
        OrderCoffeeModel(image: "orderList11", name: "병음료", nameEn: "RTD")
    ]
}
