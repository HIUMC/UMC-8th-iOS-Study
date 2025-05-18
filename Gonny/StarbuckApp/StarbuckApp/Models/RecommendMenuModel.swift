//
//  RecommendMenu.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/3/25.
//
import SwiftUI
import Foundation

struct RecommendMenu: Identifiable, ImageCardItem {
    let id = UUID()
    let name: String
    let imageName: String
}

extension RecommendMenu {
    func toCoffeeItem() -> CoffeeItem {
        return CoffeeItem(
            korName: self.name,
            engName: "", // 필요시 영어 이름 추가
            imageName: self.imageName,
            description: "설명 준비 중입니다.",
            price: 0,
            temperature: .iced, // 기본값4
            temperatureOption: .both, // 기본값
            selectedTemperature: .iced
        )
    }
}
