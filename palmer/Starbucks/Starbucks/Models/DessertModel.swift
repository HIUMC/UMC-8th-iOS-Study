//
//  DessertModel.swift
//  Starbucks
//
//  Created by 박정환 on 4/2/25.
//

import Foundation
import SwiftUI

struct DessertModel: Hashable {
    let id = UUID()
    let imageName: String
    let title: String
    
    static let dummy: [DessertModel] = [
        DessertModel(imageName: "bread1", title: "너티 크루아상"),
        DessertModel(imageName: "bread2", title: "매콤 소시지 불고기"),
        DessertModel(imageName: "bread3", title: "미니 리프 파이"),
        DessertModel(imageName: "bread4", title: "뺑 오 쇼콜라"),
        DessertModel(imageName: "bread5", title: "소시지 & 올리브 파이")
    ]
}
