//
//  BannerViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 4/4/25.
//


import Foundation
import SwiftUI

class BannerViewModel: ObservableObject  {
    var Bannername : [banner] = [
        banner(imageName: "banner1"),
        banner(imageName: "banner2"),
        banner(imageName: "banner3")
    ]
}
