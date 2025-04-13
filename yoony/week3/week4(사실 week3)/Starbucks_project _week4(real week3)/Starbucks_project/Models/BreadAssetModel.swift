//
//  BreadAssetModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/3/25.
//

import Foundation
import SwiftUI


struct BreadAssetModel: Identifiable {
    var id = UUID()
    let name: String
    let image: String
    
    init(id: UUID = UUID(), name: String, image: String) {
            self.id = id
            self.name = name
            self.image = image
        }
}


