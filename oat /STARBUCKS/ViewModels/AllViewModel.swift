//
//  AllViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/4/25.
//

import Foundation
import SwiftUI

class AllViewModel: ObservableObject  {
    var allname : [all] = [
        all(imageName: "all1", title: "텀블러"),
        all(imageName: "all2", title: "커피 용품"),
        all(imageName: "all3", title: "선물세트"),
        all(imageName: "all4", title: "보온병"),
        all(imageName: "all5", title: "라이프스타일")
    ]
}
