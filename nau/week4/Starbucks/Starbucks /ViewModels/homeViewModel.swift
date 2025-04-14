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
}

