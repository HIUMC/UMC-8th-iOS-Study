//
//  HomeViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/1/25.
//

import SwiftUI
import Observation

@Observable
class HomeViewModel {
    var selectedCoffeeModel: CoffeeDetailModel? = CoffeeDetailModel(title: "에스프레소 콘파나", englishName: "coffeeDetail2", descrip: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: 4100, temp: .ice)
    
    let dummyCoffees: [CoffeeDetailModel] = [
        CoffeeDetailModel(title: "에스프레소 콘파나", englishName: "coffeeDetail2", descrip: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: 4100, temp: .ice),
        CoffeeDetailModel(title: "아메리카노", englishName: "coffeeDetail2", descrip: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: 4100, temp: .ice),
        CoffeeDetailModel(title: "에스프레소 콘파나", englishName: "coffeeDetail2", descrip: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: 4100, temp: .ice),
        CoffeeDetailModel(title: "에스프레소 콘파나", englishName: "coffeeDetail2", descrip: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: 4100, temp: .ice),
        CoffeeDetailModel(title: "에스프레소 콘파나", englishName: "coffeeDetail2", descrip: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: 4100, temp: .ice)
        ]
}
