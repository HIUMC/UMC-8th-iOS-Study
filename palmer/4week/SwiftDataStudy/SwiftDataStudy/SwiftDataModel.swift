//
//  SwiftDataApp.swift
//  SwiftDataStudy
//
//  Created by 박정환 on 4/9/25.
//


import SwiftData
import Foundation

@Model
class Task {
    @Attribute(.unique) var title: String //고유 값만 허용
    var isDone: Bool
    var createdAt: Date
    
    @Transient var isBeingEdited: Bool = false //일시적 데이터(현재 편집 중인지 추적)
    
    init(title: String, isDone: Bool = false, createdAt: Date = .now) {
        self.title = title
        self.isDone = isDone
        self.createdAt = createdAt
    }
}
