//
//  DessertViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/5/25.
//
import SwiftUI

class DessertViewModel: ObservableObject {
    @Published var dessertItems: [DessertItem] = [
        DessertItem(name: "너티 크루아상", imageName: "bread1"),
        DessertItem(name: "매콤 소시지 불고기", imageName: "bread2"),
        DessertItem(name: "미니 리프 파이", imageName: "bread3"),
        DessertItem(name: "뺑 오 쇼콜라", imageName: "bread4"),
        DessertItem(name: "소시지&올리브 파이", imageName: "bread5")
    ]
}
