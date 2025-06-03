//
//  CoffeeMuneListModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 5/3/25.
//

import Foundation
import SwiftUI

struct CoffeeMenuListModel: Identifiable, MenuDisplayable {
    var id = UUID()
    var ENname: String
    var Korname: String
    var image: Image
}
