//
//  HomeViewModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/1/25.
//

import Foundation

@Observable
class HomeViewModel {
    var selectedCoffee: CoffeeDetailModel?
    
    var coffees = [
        CoffeeModel(img: "confanaa", name: "에스프레소 콘파나"),
        CoffeeModel(img: "macchiato", name: "에스프레소 마키아또"),
        CoffeeModel(img: "iceAmericano", name: "아이스 카페 아메리카노"),
        CoffeeModel(img: "americano", name: "카페 아메리카노"),
        CoffeeModel(img: "iceCaramel", name: "아이스 카라멜 마키아또"),
        CoffeeModel(img: "caramel", name: "카라멜 마키아또")
    ]
    
    var whatsNews = [
        WhatsNewModel(img: "homeCampaine", title: "25년 3월 일회용컵 없는 날 캠페인", detail: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요."),
        WhatsNewModel(img: "homeStore", title: "스타벅스 ooo점을 찾습니다", detail: "스타벅스 커뮤니티 스토어 파트너를 웅영할 기관을 공모합니다."),
        WhatsNewModel(img: "homeReserve", title: "2월 8일, 리저브 스프링 신규 커피 출시", detail: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요.")
    ]
    
    var deserts = [
        DesertModel(img: "desert01", name: "너티 크루아상"),
        DesertModel(img: "desert02", name: "매콤 소시지 불고기"),
        DesertModel(img: "desert03", name: "미니 리프 파이"),
        DesertModel(img: "desert04", name: "뺑 오 쇼콜라"),
        DesertModel(img: "desert05", name: "소시지&올리브 파이"),
    ]
}
