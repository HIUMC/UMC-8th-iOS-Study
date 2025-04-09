//
//  ContentViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/8/25.
//

// ContentViewModel.swift
import SwiftUI

class ContentViewModel: ObservableObject {
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
