//
//  ReceiptViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/9/25.
//

import SwiftUI

class ReceiptViewModel: ObservableObject {
    @Published private var ocrViewModel = OCRViewModel()

    var recognizedText: String {
        ocrViewModel.recognizedText
    }

    func addImage(_ image: UIImage) {
        ocrViewModel.addImage(image)
    }

    func getImages() -> [UIImage] {
        ocrViewModel.getImages()
    }
}
