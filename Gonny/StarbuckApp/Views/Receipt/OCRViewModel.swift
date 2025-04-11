//
//  OCRViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/12/25.
//
import Foundation
import SwiftData
import SwiftUI
import Vision

@Observable
class OCRViewModel {
    var context: ModelContext?

    func addImage(_ image: UIImage, context: ModelContext) {
        self.context = context
        performOCR(on: image)
    }

    private func performOCR(on uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else { return }

        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let self else { return }

            let observations = (request.results as? [VNRecognizedTextObservation]) ?? []
            let text = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
            let parsed = self.parse(from: text)

            if let imageData = uiImage.jpegData(compressionQuality: 0.8) {
                let imageModel = ReceiptsImageModel(photo: imageData)
                parsed.image = imageModel
                imageModel.receipt = parsed

                DispatchQueue.main.async {
                    self.context?.insert(parsed)
                    self.context?.insert(imageModel)
                    try? self.context?.save()
                }
            }
        }

        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR", "en-US"]
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        DispatchQueue.global(qos: .userInitiated).async {
            try? handler.perform([request])
        }
    }

    private func parse(from text: String) -> ReceiptsModel {
        let lines = text.components(separatedBy: .newlines)
        var store = "Unknown Store"
        var amount = 0

        for (i, line) in lines.enumerated() {
            if store == "Unknown Store", line.contains("점") {
                store = line
            }
            if line.contains("결제금액"), i+2 < lines.count {
                let next = lines[i+2].components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                amount = Int(next) ?? 0
            }
        }

        return ReceiptsModel(orderer: "unKnown", store: store, totalAmount: amount, orderNumber: "N/A")
    }
}
