//
//  RecommendViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/7/25.
//

import Foundation



@Observable
class RecommendViewModel {
    
    var coffeeDatas: [CoffeeCardModel] = [
        CoffeeCardModel(imageName: "conpanna", title: "에스프레소 콘파냐"),
        CoffeeCardModel(imageName: "machiato", title: "에스프레소 마키아또"),
        CoffeeCardModel(imageName: "americano", title: "아이스 카페아메리카노"),
        CoffeeCardModel(imageName: "americano_hot", title: "카페 아메리카노"),
        CoffeeCardModel(imageName: "caramel_ice", title: "아이스 캬라멜 마키아또"),
        CoffeeCardModel(imageName: "caramel_hot", title: "캬라멜 마키아또")

    ]
    
    
}
