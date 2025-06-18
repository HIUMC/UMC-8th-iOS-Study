//
//  ScrollImageModel.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 6/18/25.
//

import SwiftUI

struct ScrollImageModel: Identifiable {
    var id: UUID = .init()
    var image: String
}

var images: [ScrollImageModel] = (1...8).compactMap({_ in ScrollImageModel(image: "starbucksCard") })
