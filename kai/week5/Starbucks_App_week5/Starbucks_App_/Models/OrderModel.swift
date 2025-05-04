//
//  OrderModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 5/4/25.
//

import Foundation
import SwiftUI



struct OrderModel : Identifiable {
    let id = UUID()
    var image: ImageResource
    var name: String
    var enName: String
    var showCircle: Bool = true
}
