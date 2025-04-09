//
//  WhatsNewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/1/25.
//
import Foundation

struct WhatsNewModel: Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    let content: String
    
    static let dummy = [
        WhatsNewModel(imageName: "im1", title: "25년 3월 일회용컵 없는 날 캠페인", content: "매월 10일은 일회용컵 없는 날! 어쩌구저쩌구"),
        WhatsNewModel(imageName: "im2", title: "스타벅스 땡땡땡점을 찾습니다", content: "스타벅스 커뮤니티 파트너 어쩌구를 통해 와와"),
        WhatsNewModel(imageName: "im3", title: "2월 8일, 리저브 어쩌구 와와", content: "산뜻하고 달콤한 풍미가 가득한 입니다.")
    ]
}
