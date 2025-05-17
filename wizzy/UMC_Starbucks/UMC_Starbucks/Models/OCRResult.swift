//
//  OCRResult.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/10/25.
//

import SwiftUI

struct OCRResult: Identifiable {
    let id = UUID()
    let image: UIImage
    let receipt: ReceiptsModel
}
