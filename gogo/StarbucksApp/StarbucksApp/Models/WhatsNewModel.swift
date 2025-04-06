//
//  WhatNewModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/7/25.
//

import Foundation

import Foundation

struct WhatsNewModel: Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    let text: String
    
    static let dummy = [
        WhatsNewModel(imageName: "whatsnew1", title: "25년 3월 일회용컵 없는 날 캠페..", text: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요."),
        WhatsNewModel(imageName: "whatsnew2", title: "스타벅스 ooo점을 찾습니다", text: "스타벅스 커뮤니티 스토어 파트너를 웅영할 기관을 공모합니다."),
        WhatsNewModel(imageName: "whatsnew3", title: "2월 8일, 리저브 스프링 신규 커...", text: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요.")
    ]
}
