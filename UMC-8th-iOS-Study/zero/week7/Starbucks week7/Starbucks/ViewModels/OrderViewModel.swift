//
//  OrderViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 5/2/25.
//

import Foundation

class OrderViewModel: ObservableObject {
    
    @Published var orderproduct: [OrderModel] = [
        OrderModel(imageName: "machiato", title: "추천", englishTitle: "Recommendng"),
        OrderModel(imageName: "americano", title: "아이스 카페 아메리카노", englishTitle: "Reserve Espresso"),
        OrderModel(imageName: "americano_hot", title: "카페 아메리카노", englishTitle: "Reserve Drip"),
        OrderModel(imageName: "cappuccino", title: "카푸치노", englishTitle: "Dcaf Coffee"),
        OrderModel(imageName: "icecappuccino", title: "아이스 카푸치노", englishTitle: "Espresso"),
        OrderModel(imageName: "caramel_hot", title: "카라멜 마키아또", englishTitle: "Blonde Coffee"),
        OrderModel(imageName: "caramel_ice", title: "아이스 카라멜 마키아또", englishTitle: "Cold Brew"),
        OrderModel(imageName: "affogato", title: "아포가토/기타", englishTitle: "Others"),
        OrderModel(imageName: "cortado", title: "럼 샷 코르타도", englishTitle: "Brewed Coffee"),
        OrderModel(imageName: "breve", title: "라벤터 카페 브레베", englishTitle: "Teavana"),
        OrderModel(imageName: "bottledrink", title: "병음료", englishTitle: "RTD")
    ]
}
