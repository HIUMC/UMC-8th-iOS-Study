//
//  DetailViewModel.swift
//  Starbucks
//
//  Created by nau on 4/11/25.
//

import Foundation

@Observable
class DetailMenuViewModel {
    let currentMenu: DetailMenuModel
    let allMenus: [DetailMenuModel]
    
    init(currentMenu: DetailMenuModel, allMenus: [DetailMenuModel]) {
        self.currentMenu = currentMenu
        self.allMenus = allMenus
    }
    
    // 아이스 <-> 핫 메뉴 찾기
    func findMenu(for temp: CoffeeTemperature) -> DetailMenuModel? {
        let baseName = currentMenu.menuName.replacingOccurrences(of: "아이스 ", with: "")
        return allMenus.first {
            $0.menuName.contains(baseName) && $0.temperatures.contains(temp)
        }
    }
    
    var detailMenuModel = [
        DetailMenuModel(image: .coffeeDetail1, menuName: "에스프레소 콘파나", menuNameEn: "Espresso Con Panna", menuDescription: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: "4,100원", temperatures: [.hotonly]),
        DetailMenuModel(image: .coffeeDetail2, menuName: "에스프레소 마키아또", menuNameEn: "Espresso Macchiato", menuDescription: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료", price: "3,900원", temperatures: [.icedonly]),
        DetailMenuModel(image: .coffeeDetail3, menuName: "아이스 카페 아메리카노", menuNameEn: "Iced Caffe Americano", menuDescription: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피", price: "4,700원", temperatures: [.iced]),
        DetailMenuModel(image: .coffeeDetail4, menuName: "카페 아메리카노", menuNameEn: "Caffe Americano", menuDescription: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피", price: "4,100원", temperatures: [.hot]),
        DetailMenuModel(image: .coffeeDetail5, menuName: "아이스 카라멜 마키아또", menuNameEn: "Iced Caramel Macchiato", menuDescription: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: "6,100원", temperatures: [.iced]),
        DetailMenuModel(image: .coffeeDetail6, menuName: "카라멜 마키아또", menuNameEn: "Caramel Macchiato", menuDescription: "향긋한 바닐라 시럽과 따뜻한 스팀 밀크 위에 풍성한 우유 거품을 얹고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: "6,100원", temperatures: [.hot]),
    ]
}
