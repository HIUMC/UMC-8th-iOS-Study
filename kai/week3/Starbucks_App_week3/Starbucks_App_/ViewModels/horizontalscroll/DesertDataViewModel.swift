//
//  DesertDataViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/3/25.
//

import Foundation
import Observation

@Observable
class DesertDataViewModel: ObservableObject{
    var Deserts: [CoffeeCardModel] = [
        CoffeeCardModel(imageName: "nuttycrossant", title: "너티 크루아상"),
        CoffeeCardModel(imageName: "spicysausage", title: "매콤 소시지 불고기"),
        CoffeeCardModel(imageName: "minipie", title: "미니 리프 파이"),
        CoffeeCardModel(imageName: "chocolate", title: "뺑 오 쇼콜라"),
        CoffeeCardModel(imageName: "sausagepie", title: "소시지&올리브 파이")
    ]
}
