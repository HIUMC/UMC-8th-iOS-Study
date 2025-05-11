//
//  DetailModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/28/25.
//

import Foundation


struct DetailModel: Identifiable {
    let id = UUID()
    let nameKR: String
    let nameEN: String
    let cardImageName: String
    let detailImageName: String
    let description: String
    let price: String
    let options: [Option]
}

enum Option: String, CaseIterable {
    case iced = "ICED"
    case hot = "HOT"
}
