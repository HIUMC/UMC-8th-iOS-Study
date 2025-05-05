//
//  ItemModel.swift
//  Starbucks
//
//  Created by 박정환 on 4/7/25.
//

import Foundation
import SwiftUI

struct ItemModel: Identifiable {
    let id = UUID()
    var image: Image
    var title: String
}
