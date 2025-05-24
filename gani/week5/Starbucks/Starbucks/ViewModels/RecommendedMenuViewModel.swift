//
//  RecommendedMenuViewModel 2.swift
//  Starbucks
//
//  Created by 이가원 on 4/5/25.
//

import SwiftUI
import Foundation
class RecommendedMenuViewModel: ObservableObject {
    @Published var menus: [RecommendedMenu] = [
        RecommendedMenu(id: UUID(), name: "에스프레소 콘파나", imageName: "espresso"),
        RecommendedMenu(id: UUID(), name: "에스프레소 마키아또", imageName: "espressoma"),
        RecommendedMenu(id: UUID(), name: "아이스 카페 아메리카노", imageName: "iceamericano"),
        RecommendedMenu(id: UUID(), name: "카페 아메리카노", imageName: "hotamericano"),
        RecommendedMenu(id: UUID(), name: "아이스 카라멜 마키아또", imageName: "latte"),
        RecommendedMenu(id: UUID(), name: "카라멜 마키아또", imageName: "caramel")
    ]
}
