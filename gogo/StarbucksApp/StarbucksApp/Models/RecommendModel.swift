//
//  recommendMenu.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/7/25.
//



import Foundation
import SwiftUI

struct RecommendModel: Identifiable  {
    let id = UUID()
    let imageName: String
    let title: String
    
    static let dummy: [RecommendModel] = [
        RecommendModel(imageName: "coffee1", title: "에스프레소 콘파나"),
        RecommendModel(imageName: "coffee2", title: "에스프레소 마끼아또"),
        RecommendModel(imageName: "coffee3", title: "아이스 카페 아메리카노"),
        RecommendModel(imageName: "coffee4", title: "카페 아메리카노"),
        RecommendModel(imageName: "coffee5", title: "아이스 카라멜 마끼아또"),
        RecommendModel(imageName: "coffee6", title: "카라멜 마끼아또")
    ]
}
