//
//  OrderCoffeeViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 5/2/25.
//

import Foundation
class OrderCoffeeViewModel: ObservableObject {
    var selectMenu: OrderCoffeeModel? = OrderCoffeeModel(title: "에스프레소 콘 파나", engTitle: "Espresso Con Panna",image: "conPanna")
    let OrderCoffeeItem: [OrderCoffeeModel] = [
        OrderCoffeeModel(title: "추천", engTitle: "Recommend",image: "O_recommandCoffee") ,
        OrderCoffeeModel(title: "아이스 카페 아메리카노", engTitle: "Reserve Espresso",image: "O_icedAmericano") ,
        OrderCoffeeModel(title: "카페 아메리카노", engTitle: "Reserve Drip",image: "O_hotAmericano") ,
        OrderCoffeeModel(title: "카푸치노", engTitle: "Dcaf Coffee",image: "O_caffucino") ,
        OrderCoffeeModel(title: "아이스 카푸치노", engTitle: "Espresso",image: "O_icedCaffucino") ,
        OrderCoffeeModel(title: "카라멜 마키아또", engTitle: "Blonde Coffee",image: "O_caramelHot") ,
        OrderCoffeeModel(title: "아이스 카라멜 마키아또", engTitle: "Cold Brew",image: "O_caramelIced") ,
        OrderCoffeeModel(title: "아포가토/기타", engTitle: "Others",image: "O_affogato") ,
        OrderCoffeeModel(title: "럼 샷 코르타도", engTitle: "Brewed Coffee",image: "O_cortado") ,
        OrderCoffeeModel(title: "라벤터 카페 브레베", engTitle: "Teavana",image: "O_lavender") ,
        OrderCoffeeModel(title: "병음료", engTitle: "RTD",image: "O_bottle")
        
    ]
    
}
