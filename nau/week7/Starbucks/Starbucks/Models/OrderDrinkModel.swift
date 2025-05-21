//
//  OrderDrinkModel.swift
//  Starbucks
//
//  Created by nau on 5/1/25.
//

import Foundation
import SwiftUI

struct OrderDrinkModel : Identifiable {
    let id = UUID()
    var image: ImageResource
    var name: String
    var enName: String
    var showCircle: Bool = true
}
