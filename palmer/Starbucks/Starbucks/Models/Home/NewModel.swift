//
//  NewsModel.swift
//  Starbucks
//
//  Created by 박정환 on 4/2/25.
//

import Foundation

struct NewModel: Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    let content: String
    
    static let dummy = [
        NewModel(imageName: "news1", title: "25년 3월 일회용컵 없는 날 캠페..", content: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요."),
        NewModel(imageName: "news2", title: "스타벅스 ooo점을 찾습니다", content: "스타벅스 커뮤니티 스토어 파트너를 웅영할 기관을 공모합니다."),
        NewModel(imageName: "news3", title: "2월 8일, 리저브 스프링 신규 커...", content: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요.")
    ]
}
