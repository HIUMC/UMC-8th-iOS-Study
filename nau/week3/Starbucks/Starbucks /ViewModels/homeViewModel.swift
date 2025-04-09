//
//  homeViewModel.swift
//  Starbucks
//
//  Created by nau on 4/3/25.
//

import Foundation

@Observable
class HomeViewModel {
    var recommendMenuModel1 = [
        RecommendMenuModel(image: .coffee1, name: "에스프레소 콘파나"),
        RecommendMenuModel(image: .coffee2, name: "에스프레소 마키아또"),
        RecommendMenuModel(image: .coffee3, name: "아이스 카페 아메리카노"),
        RecommendMenuModel(image: .coffee4, name: "카페 아메리카노"),
        RecommendMenuModel(image: .coffee5, name: "아이스 카라멜 마키아또"),
        RecommendMenuModel(image: .coffee6, name: "카라멜 마키아또")
    ]
    
    var newsModel = [
        NewsModel(title: "25년 3월 일회용컵 없는 날 캠페인 개최!", description: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요.", image: .news1),
        NewsModel(title: "스타벅스 ooo점을 찾습니다", description: "스타벅스 커뮤니티 스토어 파트너를 웅영할 기관을 공모합니다.", image: .news2),
        NewsModel(title: "2월 8일, 리저브 스프링 신규 커피 발매!", description: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요.", image: .news3)
    ]
    
    var recommendMenuModel2 = [
        RecommendMenuModel(image: .bakery1, name: "너티 크루아상"),
        RecommendMenuModel(image: .bakery2, name: "매콤 소시지 불고기"),
        RecommendMenuModel(image: .bakery3, name: "미니 리프 파이"),
        RecommendMenuModel(image: .bakery4, name: "뺑 오 쇼콜라"),
        RecommendMenuModel(image: .bakery5, name: "소시지&올리브 파이")
    ]
    
    var detailMenuModel = [
        DetailMenuModel(image: .coffeeDetail1, menuName: "에스프레소 콘파나", menuNameEn: "Espresso Con Panna", menuDescription: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: "4,100원", temperatures: [.hot]),
        DetailMenuModel(image: .coffeeDetail2, menuName: "에스프레소 마키아또", menuNameEn: "Espresso Macchiato", menuDescription: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료", price: "3,900원", temperatures: [.hot]),
        DetailMenuModel(image: .coffeeDetail3, menuName: "아이스 카페 아메리카노", menuNameEn: "Iced Caffe Americano", menuDescription: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피", price: "4,700원", temperatures: [.iced]),
        DetailMenuModel(image: .coffeeDetail4, menuName: "카페 아메리카노", menuNameEn: "Caffe Americano", menuDescription: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피", price: "4,100원", temperatures: [.hot]),
        DetailMenuModel(image: .coffeeDetail5, menuName: "아이스 카라멜 마키아또", menuNameEn: "Iced Caramel Macchiato", menuDescription: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: "6,100원", temperatures: [.iced]),
        DetailMenuModel(image: .coffeeDetail6, menuName: "카라멜 마키아또", menuNameEn: "Caramel Macchiato", menuDescription: "향긋한 바닐라 시럽과 따뜻한 스팀 밀크 위에 풍성한 우유 거품을 얹고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: "6,100원", temperatures: [.hot]),
    ]
    
    var sample: DetailMenuModel {
        detailMenuModel.first!
    }
}

