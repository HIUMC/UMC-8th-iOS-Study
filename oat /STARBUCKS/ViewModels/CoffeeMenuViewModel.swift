//
//  CoffeeMenuViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 5/12/25.
//

import Foundation

class CoffeeMenuViewModel: ObservableObject {
    @Published var coffeeMenus: [CoffeeMenu] = [
        CoffeeMenu(imageName: "co1", koreanName: "추천", englishName: "Recommend"),
        CoffeeMenu(imageName: "co2", koreanName: "아이스 카페 아메리카노", englishName: "Reserve Espresso"),
        CoffeeMenu(imageName: "co3", koreanName: "카페 아메리카노", englishName: "Reserve Drip"),
        CoffeeMenu(imageName: "co4", koreanName: "카푸치노", englishName: "Dcaf Coffee"),
        CoffeeMenu(imageName: "co5", koreanName: "아이스 카푸치노", englishName: "Espresso"),
        CoffeeMenu(imageName: "co6", koreanName: "카라멜 마키아또", englishName: "Blonde Coffee"),
        CoffeeMenu(imageName: "co7", koreanName: "아이스 카라멜 마키아또", englishName: "Americano"),
        CoffeeMenu(imageName: "co8", koreanName: "아포가토/기타", englishName: "Others"),
        CoffeeMenu(imageName: "co9", koreanName: "럼 샷 코르타도", englishName: "Brewed Coffee"),
        CoffeeMenu(imageName: "co10", koreanName: "라벤터 카페 브레베", englishName: "Teavana"),
        CoffeeMenu(imageName: "co11", koreanName: "병음료", englishName: "RTD"),
    ]
}
