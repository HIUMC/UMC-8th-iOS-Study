//
//  OrderViewModel.swift
//  Starbucks
//
//  Created by 이가원 on 5/23/25.
//

import SwiftUI
import Foundation

class OrderMenuViewModel: ObservableObject {
    @Published var ordermenu: [OrderMenu] = [
        OrderMenu(id: UUID(), nameKo: "추천", nameEn: "Recommend", imageName: "macchiato", isNew: true),
        OrderMenu(id: UUID(), nameKo: "아이스 카페 아메리카노", nameEn: "Reserve Espresso", imageName: "americanpCold", isNew: true),
        OrderMenu(id: UUID(), nameKo: "카페 아메리카노", nameEn: "Reserve Drip", imageName: "americanoHot", isNew: true),
        OrderMenu(id: UUID(), nameKo: "카푸치노", nameEn: "Decaf Coffee", imageName: "capuccinoHot", isNew: false),
        OrderMenu(id: UUID(), nameKo: "아이스 카푸치노", nameEn: "Espresso", imageName: "capuccinoIce", isNew: true),
        OrderMenu(id: UUID(), nameKo: "카라멜 마키아또", nameEn: "Blonde Coffee", imageName: "caramelHot", isNew: true),
        OrderMenu(id: UUID(), nameKo: "아이스 카라멜 마키아또", nameEn: "Cold Brew", imageName: "caramerlCold", isNew: true),
        OrderMenu(id: UUID(), nameKo: "아포가토/기타", nameEn: "Others", imageName: "apogatto", isNew: false),
        OrderMenu(id: UUID(), nameKo: "럼 샷 코르타도", nameEn: "Brewed Coffee", imageName: "rumshot", isNew: true),
        OrderMenu(id: UUID(), nameKo: "라벤더 카페 브레베", nameEn: "Teavana", imageName: "rabento", isNew: true),
        OrderMenu(id: UUID(), nameKo: "병음료", nameEn: "RTD", imageName: "bottle", isNew: false)
    ]
}
