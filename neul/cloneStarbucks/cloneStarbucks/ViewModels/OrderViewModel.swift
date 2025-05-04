//
//  OrderViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/28/25.
//

import SwiftUI
import Observation

@Observable
class OrderViewModel {
    var drinks: [DrinkModel] = [
        DrinkModel(title: "추천", imageName: "coffeeDetail1", descrip: "Recommend"),
        DrinkModel(title: "아이스 카페 아메리카노", imageName: "coffeeDetail3", descrip: "Reserve Espresso"),
        DrinkModel(title: "카페 아메리카노", imageName: "coffeeDetail4", descrip: "Reserve Drip"),
        DrinkModel(title: "카푸치노", imageName: "drink1", descrip: "Dcaf Coffee"),
        DrinkModel(title: "아이스 카푸치노", imageName: "drink2", descrip: "Espresso"),
        DrinkModel(title: "카라멜 마끼아또", imageName: "coffeeDetail6", descrip: "Blonde Coffee"),
        DrinkModel(title: "아이스 카라멜 마끼아또", imageName: "coffeeDetail5", descrip: "Cold Brew"),
        DrinkModel(title: "아포가토/기타", imageName: "drink3", descrip: "Others"),
        DrinkModel(title: "럼 샷 코르타도", imageName: "drink4", descrip: "Brewed Coffee"),
        DrinkModel(title: "라벤더 카페 브레베", imageName: "drink5", descrip: "Teavana"),
        DrinkModel(title: "병음료", imageName: "drink6", descrip: "RTD")
    ]
}
