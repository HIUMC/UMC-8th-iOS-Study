//
//  DataModel.swift
//  week4Extra
//
//  Created by tokkislove on 4/7/25.
//
import Foundation
import SwiftData

@Model
class Task {
    @Attribute(.unique) var title: String
    var isDone: Bool
    var createdAt: Date
    
    @Transient var isBeingEdited: Bool = false // 임시변수라캅니다...(예?)
    
    init(title: String, isDone: Bool = false, createdAt: Date = .now) {
        self.title = title
        self.isDone = isDone
        self.createdAt = createdAt
    }
}
