//
//  DessertViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/28/25.
//

import Foundation
import SwiftUI

class DessertViewModel: ObservableObject  {
    var Dessertname : [dessert] = [
        dessert(imageName: "bbang1"),
        dessert(imageName: "bbang2"),
        dessert(imageName: "bbang3"),
        dessert(imageName: "bbang4"),
        dessert(imageName: "bbang5")
    ]
}
    
