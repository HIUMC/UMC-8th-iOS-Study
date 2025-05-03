//
//  HomeViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 4/4/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var coffeemenus: [CoffeeCard] = [
        CoffeeCard(cimageName: "conpanna", cmenuName: "에스프레소 콘파나"),
        CoffeeCard(cimageName: "machiato", cmenuName: "에스프레소 마키아또"),
        CoffeeCard(cimageName: "americano", cmenuName: "아이스 카페 아메리카노"),
        CoffeeCard(cimageName: "americano_hot", cmenuName: "카페 아메리카노"),
        CoffeeCard(cimageName: "caramel_ice", cmenuName: "아이스 카라멜 마키아또"),
        CoffeeCard(cimageName: "caramel_hot", cmenuName: "카라멜 마키아또")
    ]
    
    @Published var breadmenus: [BreadCard] = [
        BreadCard(bimageName: "nuttycrossant", bmenuName: "너티 크루아상"),
        BreadCard(bimageName: "spicysausage", bmenuName: "매콤 소시지 불고기"),
        BreadCard(bimageName: "minipie", bmenuName: "미니 리프 파이"),
        BreadCard(bimageName: "chocolate", bmenuName: "뺑 오 쇼콜라"),
        BreadCard(bimageName: "sausagepie", bmenuName: "소시지 올리브 파이")
    ]
}

