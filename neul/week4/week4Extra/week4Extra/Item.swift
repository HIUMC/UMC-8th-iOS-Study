//
//  Item.swift
//  week4Extra
//
//  Created by tokkislove on 4/7/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
