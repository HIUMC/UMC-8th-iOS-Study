//
//  OrderViewModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/29/25.


//Observable Macro 사용

import Foundation
import Observation

///Observable 매크로 이용 -> ObservableObject , Published 안 써도됌 .
@Observable
class OrderViewModel {
    var selectedTopTab: TopTab = .allMenu
    var selectedBottomTab: BottomTab = .drink
    var showStoreSheet: Bool = false
    var orderList: [OrderModel] = []
    
    init() {
        orderList = [
            OrderModel(name: "추천", subTitle: "Recommend", imageName: "order1"),
            OrderModel(name: "아이스 카페 아메리카노", subTitle: "Reserve Espresso", imageName: "order2"),
            OrderModel(name: "카페 아메리카노", subTitle: "Reserve Drip", imageName: "order3"),
            OrderModel(name: "카푸치노", subTitle: "Dcaf Coffee", imageName: "order4"),
            OrderModel(name: "아이스 카푸치노", subTitle: "Espresso", imageName: "order5"),
            OrderModel(name: "카라멜 마끼아또", subTitle: "Blonde Coffee", imageName: "order6"),
            OrderModel(name: "아이스 카라멜 마끼아또", subTitle: "Cold Brew", imageName: "order7"),
            OrderModel(name: "아포카토/기타", subTitle: "Others", imageName: "order8"),
            OrderModel(name: "럼 샷 코르타도", subTitle: "Brewed Coffee", imageName: "order9"),
            OrderModel(name: "라벤더 카페 브레베", subTitle: "Teavana", imageName: "order10"),
            OrderModel(name: "병음료", subTitle: "RTD", imageName: "order11")
        ]
    }
}

//MARK: -enum 이용해서 상단탭바(열거형)!!
enum TopTab: String, CaseIterable {
    case allMenu = "전체 메뉴"
    case myMenu = "나만의 메뉴"
    case cakeReservation = "홀케이크 예약"
}
//MARK: -enum 이용해서 하단탭바(열거형)!!
enum BottomTab: String, CaseIterable {
    case drink = "음료"
    case food = "푸드"
    case product = "상품"
}
