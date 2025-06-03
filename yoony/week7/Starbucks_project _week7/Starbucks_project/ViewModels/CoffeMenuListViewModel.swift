//
//  CoffeMenuListViewModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/3/25.
//

import Foundation
import SwiftUI
import Observation

@Observable
class CoffeMenuListViewModel{
    
    let Coffees: [CoffeeMenuListModel] = [
        CoffeeMenuListModel(ENname: "Recommend", Korname: "추천", image: Image("c1")),
        CoffeeMenuListModel(ENname: "Reserve Espresso", Korname: "아이스 카페 아메리카노", image: Image("c2")),
        CoffeeMenuListModel(ENname: "Reserve Drip", Korname: "카페 아메리카노", image: Image("c3")),
        CoffeeMenuListModel(ENname: "Decaf Coffee", Korname: "카푸치노", image: Image("c4")),
        CoffeeMenuListModel(ENname: "Espresso", Korname: "아이스 카푸치노", image: Image("c5")),
        CoffeeMenuListModel(ENname: "Blonde Coffee", Korname: "카라멜 마키아또", image: Image("c6")),
        CoffeeMenuListModel(ENname: "Cold Brew", Korname: "아이스 카라멜 마키아또", image: Image("c7")),
        CoffeeMenuListModel(ENname: "Others", Korname: "아포가토/기타", image: Image("c8")),
        CoffeeMenuListModel(ENname: "Brewed Coffee", Korname: "럼 샷 코르타도", image: Image("c9")),
        CoffeeMenuListModel(ENname: "Teavana", Korname: "라벤더 카페 브레베", image: Image("c10")),
        CoffeeMenuListModel(ENname: "RTD", Korname: "병음료", image: Image("c11"))
    ]
}
