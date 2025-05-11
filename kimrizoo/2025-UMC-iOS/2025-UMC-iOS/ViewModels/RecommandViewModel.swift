//
//  RecommandViewModel.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/3/25.
//

import Foundation
import SwiftUI

@Observable
class RecommendViewModel {
    
    var coffeeItems: [CoffeeItem] = [
        CoffeeItem(name: "에스프레소 콘파나", imageName: "espresso_conpanna"),
        CoffeeItem(name: "에스프레소 마끼아또", imageName: "espresso_macchiato"),
        CoffeeItem(name: "아이스 카페 아메리카노", imageName: "iced_americano"),
        CoffeeItem(name: "카페 아메리카노", imageName: "cafe_americano"),
        CoffeeItem(name: "아이스 카라멜 마끼아또", imageName: "iced_caramel_macchiato"),
        CoffeeItem(name: "카라멜 마키아또", imageName: "caramel_macchiato")
    ]
    
    var dessertItems: [CoffeeItem] = [
        CoffeeItem(name: "너티 크루아상", imageName: "nuttyCroissant"),
        CoffeeItem(name: "매콤 소시지 불고기", imageName: "spicySausageBulgogi"),
        CoffeeItem(name: "미니 리프 파이", imageName: "miniLeafPie"),
        CoffeeItem(name: "뺑 오 쇼콜라", imageName: "painAuChocolat"),
        CoffeeItem(name: "소시지&올리브 파이", imageName: "sausageOlivePie")
        ]
}

