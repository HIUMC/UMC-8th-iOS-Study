//
//  WhatViewModel.swift
//  Starbucks
//
//  Created by 김영택 on 4/7/25.
//

import Foundation

class WhatViewModel: ObservableObject {
    
    @Published var whatCard : [WhatModel] = [
        WhatModel(imageName: "zerodisposable", title:"25년 3월 일회용컵 없는 날 캠페..", add: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매 장에서 개인컵 및 다회용 컵을 이용하세요."),
        WhatModel(imageName: "partnership", title:"스타벅스 ooo점을 찾습니다", add: "스타벅스 커뮤니티 스토어 파트너를 웅영할 기관 을 공모합니다."),
        WhatModel(imageName: "springreserve", title:"2월 8일, 리저브 스프링 신규 커...", add: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세 요.")
    ]
}
