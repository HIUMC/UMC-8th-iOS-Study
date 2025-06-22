//
//  DesertViewModel.swift
//  Starbucks
//
//  Created by 이가원 on 4/5/25.
//

import SwiftUI
import Foundation


class DesertMenuViewModel: ObservableObject {
    @Published var desertmenus: [DesertMenu] = [
        DesertMenu(id: UUID(), name: "너티 크루아상", imageName: "desert1"),
        DesertMenu(id: UUID(), name: "매콤 소시지 불고기", imageName: "desert2"),
        DesertMenu(id: UUID(), name: "미니 리프 파이", imageName: "desert3"),
        DesertMenu(id: UUID(), name: "뺑 오 쇼콜라", imageName: "desert4"),
        DesertMenu(id: UUID(), name: "소시지&올리브 파이", imageName: "desert5")
    ]
}
