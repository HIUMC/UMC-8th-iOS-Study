//
//  ShopViewModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/10/25.
//

import Foundation
import SwiftUI
import Observation

@Observable

class ShopViewModel: ObservableObject {
    
    let images: [String] = [
        "bestitem1", "bestitem2", "bestitem3", "bestitem4",
        "bestitem5", "bestitem6", "bestitem7", "bestitem8"
    ]
    
    let newproduct : [String] = ["newproduct1", "newproduct2", "newproduct3", "newproduct4"]
}
