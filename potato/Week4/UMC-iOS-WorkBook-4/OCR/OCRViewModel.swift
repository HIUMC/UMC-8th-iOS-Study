//
//  OCRViewModel.swift
//  UMC-iOS-WorkBook-4
//
//  Created by 곽은채 on 4/7/25.
//

import Foundation
import Vision
import UIKit
import Observation

@Observable
class OCRViewModel: OCRImageHandling {
    var images: [UIImage] = []
    var recognizedText: String = ""

    func addImage(_ image: UIImage) {
        images.append(image)
        performOCR(on: image)
    }

    func removeImage(at index: Int) {
        guard images.indices.contains(index) else { return }
        images.remove(at: index)
    }

    func getImages() -> [UIImage] {
        images
    }

    private func performOCR(on uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else { return }

        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let results = request.results as? [VNRecognizedTextObservation] else { return }
            let recognizedStrings = results.compactMap { $0.topCandidates(1).first?.string }

            DispatchQueue.main.async {
                self?.recognizedText = recognizedStrings.joined(separator: "\n")
            }
        }

        request.recognitionLevel = .accurate
        request.usesLanguageCorrection = true
        request.recognitionLanguages = ["ko-KR", "en-US"]

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])

        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }
}
