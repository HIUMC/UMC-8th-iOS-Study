//
//  DessertModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/5/25.
//

import Foundation

struct DessertItem: Identifiable, ImageCardItem {
    let id = UUID()
    let name: String
    let imageName: String
}
