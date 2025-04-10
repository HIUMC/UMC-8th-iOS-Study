//
//  HomeViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/1/25.
//

import SwiftUI

class CoffeeDetailViewModel: ObservableObject {
    
    @Published var coffees: [CoffeeDetailModel] = [
        CoffeeDetailModel(title: "에스프레소 콘파나", englishName: "Espresso Con Panna", imageName: "coffeeDetail1", descrip: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: 4100, temp: [.hot]),
        CoffeeDetailModel(title: "에스프레소 마끼아또", englishName: "Espresso Macchiato", imageName: "coffeeDetail2", descrip: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료", price: 3900, temp: [.ice]),
        CoffeeDetailModel(title: "아이스 카페 아메리카노", englishName: "Iced Caffe Americano", imageName: "coffeeDetail3", descrip: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피", price: 4700, temp: [.ice, .hot]),
        CoffeeDetailModel(title: "카페 아메리카노", englishName: "Caffe Americano", imageName: "coffeeDetail4", descrip: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피", price: 4700, temp: [.hot, .ice]),
        CoffeeDetailModel(title: "아이스 카라멜 마끼아또", englishName: "Iced Caramel Macchiato", imageName: "coffeeDetail5", descrip: "향긋한 바닐라 시럽과 시원한 우유에 얼음을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: 6100, temp: [.ice]),
        CoffeeDetailModel(title: "카라멜 마끼아또", englishName: "Caramel Macchiato", imageName: "coffeeDetail6", descrip: "향긋한 바닐라 시럽과 따뜻한 스팀 밀크 위에 풍성한 우유 거품을 얹고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: 6100, temp: [.hot, .ice])
    ]
    
    @Published var recoCoffees: [RecoMenuModel] = [
        RecoMenuModel(imageName: "c1", title: "에스프레소 콘파나"),
        RecoMenuModel(imageName: "c2", title: "에스프레소 마끼아또"),
        RecoMenuModel(imageName: "c3", title: "아이스 카페 아메리카노"),
        RecoMenuModel(imageName: "c4", title: "카페 아메리카노"),
        RecoMenuModel(imageName: "c5", title: "카라멜 마끼아또")
    ]
    
}
