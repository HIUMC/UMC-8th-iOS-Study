//
//  WhatsNewModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/1/25.
//

import Foundation

struct WhatsNewModel: Identifiable {
    let id = UUID()
    var img: String
    var title: String
    var detail: String
}
