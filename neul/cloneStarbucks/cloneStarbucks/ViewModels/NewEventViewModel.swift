//
//  NewEventViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/3/25.
//
import SwiftUI
import Observation

@Observable
class NewEventViewModel {
    var newEvents: [WhatsNewModel] = [
        WhatsNewModel(imageName: "im1", title: "25년 3월 일회용컵 없는 날 캠페인", content: "매월 10일은 일회용컵 없는 날! 스타벅스 에모 매장에서 개인컵 및 다회용 컵을 이용하세요."),
        WhatsNewModel(imageName: "im2", title: "스타벅스 000점을 찾습니다", content: "스타벅스 커뮤니티 스토어 파트너를 운영할 기관을 공모합니다."),
        WhatsNewModel(imageName: "im3", title: "2월 8일, 리저브 스프링 신규 커피 출시", content: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요.")
    ]
}
