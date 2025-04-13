//
//  CoffeeViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/3/25.
//

import Foundation
import Observation

class CoffeeViewModel: ObservableObject {
    @Published var selectedMenu: CoffeeModel?
    @Published var coffeeDetails: [CoffeeModel] = [
        CoffeeModel(imageName: "caramelCold_square", name: "아이스 카라멜 마끼아또", englishName: "Iced Caramel Macchiato", description: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부\n은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price:6100 , availableTypes: [.iced, .hot]),
        CoffeeModel(imageName: "caramelHot_Square", name: "카라멜 마끼아또", englishName: "Caramel Macchiato", description: "향긋한 바닐라 시럽과 따뜻한 스팀 밀크 위에 풍성한 우유 거품을 얹고 점을 찍\n듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피\n음료", price:6100 , availableTypes: [.iced, .hot]),
        CoffeeModel(imageName: "americanpCold_square", name: "아이스 카페 아메리카노", englishName: "Iced Caffe Americano", description: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬\n한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피", price:4700 , availableTypes: [.iced, .hot]),
        CoffeeModel(imageName: "americanoHot_square", name: "카페 아메리카노", englishName: "Caffe Americano", description: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소\n를 가장 부드럽게 잘 느낄 수 있는 커피", price:4700 , availableTypes: [.iced, .hot]),

        CoffeeModel(imageName: "confana_square", name: "에스프레소 콘 파나", englishName: "Espresso Con Panna", description: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의\n맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: 4100, availableTypes: [.iced, .hot]),
        
        CoffeeModel(imageName: "macchiato_square", name: "에스프레소 마끼아또", englishName: "Espresso Macchiato", description: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프\n레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료", price: 3900, availableTypes: [.iced, .hot])
        
    ]
    
    func selectMenu(name: String) {
            selectedMenu = coffeeDetails.first(where: { $0.name == name })
        }
}
