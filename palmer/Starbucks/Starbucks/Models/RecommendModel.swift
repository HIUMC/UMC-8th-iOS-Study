//
//  RecommendModel.swift
//  Starbucks
//
//  Created by 박정환 on 4/2/25.
//

import Foundation
import SwiftUI

struct RecommendModel: Identifiable  {
    let id = UUID()
    let imageName: String
    let title: String
    
    static let dummy: [RecommendModel] = [
        RecommendModel(imageName: "rec1", title: "에스프레소 콘파나"),
        RecommendModel(imageName: "rec2", title: "에스프레소 마끼아또"),
        RecommendModel(imageName: "rec3", title: "아이스 카페 아메리카노"),
        RecommendModel(imageName: "rec4", title: "카페 아메리카노"),
        RecommendModel(imageName: "rec5", title: "아이스 카라멜 마끼아또"),
        RecommendModel(imageName: "rec6", title: "카라멜 마끼아또")
    ]
}
