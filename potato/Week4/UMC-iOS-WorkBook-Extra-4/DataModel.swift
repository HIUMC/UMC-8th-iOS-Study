//
//  DataModel.swift
//  UMC-iOS-WorkBook-Extra-4
//
//  Created by 곽은채 on 4/5/25.
//

import Foundation
import SwiftData

@Model // 모델 정의, class에서만 사용
class Task {
    @Attribute(.unique) var title: String // 특정 속성에 대한 세부 설정, unique 고유한 값
    var isDone: Bool
    var createdAt: Date
    
    @Transient var isBeingEdited: Bool = false // 저장 X 속성(일시적 데이터 처리)
    
    init(title: String, isDone: Bool = false, createdAt: Date = .now) {
        self.title = title
        self.isDone = isDone
        self.createdAt = createdAt
    }
}
