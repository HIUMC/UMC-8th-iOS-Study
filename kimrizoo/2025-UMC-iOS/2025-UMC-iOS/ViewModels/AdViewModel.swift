//
//  AdViewModel.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/3/25.
//

import SwiftUI

@Observable
class AdViewModel {
    var ads: [AdItem] = [
        AdItem(title: "25년 3월 일회용컵 없는 날 캠페인", description: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요.", imageName: "ad_campaign"),
        AdItem(title: "스타벅스 000점을 찾습니다", description: "스타벅스 커뮤니티 스토어 파트너를 운영할 기관을 공모합니다.", imageName: "ad_store"),
        AdItem(title: "2월 8일, 리저브 스프링 신규 커...", description: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요.", imageName: "ad_new_drink")
    ]
}
