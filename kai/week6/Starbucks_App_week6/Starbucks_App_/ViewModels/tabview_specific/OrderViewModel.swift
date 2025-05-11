//
//  OrderViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/4/25.
//

import Foundation

@Observable
class OrderViewModel {
    var orderDrinkViewModel = [
        OrderModel(image: .conpanna1, name: "추천", enName: "Recommend"),
        OrderModel(image: .americano, name: "아이스 카페 아메리카노", enName: "Reserve Espresso"),
        OrderModel(image: .americanoHot, name: "카페 아메리카노", enName: "Reserve Drip"),
        OrderModel(image: .cappuccinoHot, name: "카푸치노", enName: "Dcaf Coffee"),
        OrderModel(image: .cappuccinoIce, name: "아이스 카푸치노", enName: "Espresso"),
        OrderModel(image: .caramelHot, name: "카라멜 마끼아또", enName: "Blonde Coffee"),
        OrderModel(image: .caramelIce, name: "아이스 카라멜 마끼아또", enName: "Cold Brew"),
        OrderModel(image: .affogato, name: "아포가토/기타", enName: "Others", showCircle: false),
        OrderModel(image: .cortado, name: "럼 샷 코르타도", enName: "Brewed Coffee"),
        OrderModel(image: .lavender, name: "라벤터 카페 브레베", enName: "Teavana"),
        OrderModel(image: .bottle, name: "병음료", enName: "RTD", showCircle: false)
            ]
        }
