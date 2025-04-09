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
}
