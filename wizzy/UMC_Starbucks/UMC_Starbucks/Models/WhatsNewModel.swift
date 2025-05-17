//
//  WhatsNewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import Foundation
import SwiftUI

struct WhatsNewModel: Identifiable {
    let id = UUID()
    let imageName: String
    let newsTitle: String
    let newsContent: String
}

