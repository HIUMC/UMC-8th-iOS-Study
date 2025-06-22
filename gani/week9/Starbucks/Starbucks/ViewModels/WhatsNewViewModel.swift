//
//  WhatsNewViewModel.swift
//  Starbucks
//
//  Created by 이가원 on 4/5/25.
//
import SwiftUI
import Foundation
class WhatsNewViewModel: ObservableObject {
    @Published var whatsnews: [WhatsNew] = [
        WhatsNew(
            id: UUID(),
            title: "25년 3월 일회용컵 없는 날 캠페..",
            text: "매월 10일은 일회용컵 없는 날! 스타벅스 에코매장\n에서 개인컵 및 다회용 컵을 이용하세요.",
            imageName: "newimg1"
        ),
        WhatsNew(
            id: UUID(),
            title: "스타벅스 000점을 찾습니다",
            text: "스타벅스 커뮤니티 스토어 파트너를 운영할 기관\n을 공모합니다.",
            imageName: "newimg2"
        ),
        WhatsNew(
            id: UUID(),
            title: "2월 8일, 리저브 스프링 신규 커...",
            text: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세\n요.",
            imageName: "newimg3"
        )
    ]
}
