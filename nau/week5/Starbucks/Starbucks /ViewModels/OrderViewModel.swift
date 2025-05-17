//
//  OrderDrinkViewModel.swift
//  Starbucks
//
//  Created by nau on 5/1/25.
//

import Foundation

@Observable
class OrderViewModel {
    var orderDrinkViewModel = [
        OrderDrinkModel(image: .coffee1, name: "추천", enName: "Recommend", circle: true),
        OrderDrinkModel(image: .coffee1, name: "아이스 카페 아메리카노", enName: "Reserve Espresso", circle: true),
        OrderDrinkModel(image: .coffee2, name: "카페 아메리카노", enName: "Reserve Drip", circle: true),
        OrderDrinkModel(image: .coffee3, name: "카푸치노", enName: "Dcaf Coffee", circle: true),
        OrderDrinkModel(image: .coffee4, name: "아이스 카푸치노", enName: "Espresso", circle: true),
        OrderDrinkModel(image: .coffee5, name: "카라멜 마끼아또", enName: "Blonde Coffee", circle: true),
        OrderDrinkModel(image: .coffee6, name: "아이스 카라멜 마끼아또", enName: "Cold Brew", circle: true),
        OrderDrinkModel(image: .coffee1, name: "아포가토/기타", enName: "Others", circle: false),
        OrderDrinkModel(image: .coffee1, name: "럼 샷 코르타도", enName: "Brewed Coffee", circle: true),
        OrderDrinkModel(image: .coffee1, name: "라벤터 카페 브레베", enName: "Teavana", circle: true),
        OrderDrinkModel(image: .coffee1, name: "병음료", enName: "RTD", circle: false)
    ]
}
