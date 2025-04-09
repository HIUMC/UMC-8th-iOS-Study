//
//  AdItem.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/3/25.
//

import Foundation

struct AdItem: Identifiable {
    let id: UUID = UUID()
    var title: String
    var description: String
    var imageName: String
}
