//
//  WhatsnewViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import Foundation

class WhatsnewViewModel: ObservableObject {
    var WhatsNewData: [WhatsNewModel] = [
        WhatsNewModel(imageName: "new1", newsTitle: "25년 3월 일회용컵 없는 날 캠페..", newsContent: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매\n장에서 개인컵 및 다회용 컵을 이용하세요."),
        WhatsNewModel(imageName: "new2", newsTitle: "스타벅스 ooo점을 찾습니다", newsContent: "스타벅스 커뮤니티 스토어 파트너를 운영할 기관\n을 공모합니다."),
        WhatsNewModel(imageName: "new3", newsTitle: "2월 8일, 리저브 스프링 신규 커...", newsContent: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요.")
    ]
    
}
