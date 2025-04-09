//
//  ReceiptsViewModel.swift
//  4st_Practice
//
//  Created by 이서현 on 4/6/25.
//

import SwiftUI
import Vision

@Observable
class ReceiptsViewModel {
    var selectedSegment: ReceiptSegment = .first {
    /* didSet에 대해 스스로 학습하시기 바라겠습니다. */
        didSet {
            startOCR(selectedSegment)
        }
    }
}

func startOCR(_ segment: ReceiptSegment) {
        guard let uiImage = UIImage(named: segment.imageName),
              let cgImage = uiImage.cgImage else {
            self.currentReceipt = nil
            return
        }

        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let self = self,
                  let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                self?.currentReceipt = nil
                return
            }

            let recognizedStrings = observations.compactMap { $0.topCandidates(1).first?.string }
            let fullText = recognizedStrings.joined(separator: "\n")
            let parsed = self.parseWithoutRegex(from: fullText)

            DispatchQueue.main.async {
                self.currentReceipt = parsed
            }
        }

        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR"]
        
        /* 이 부분을 DispatchQueue를 삭제하거나 우선순위를 바꿔가며 한 번 돌려보세요! 다른 경험을 보게 될 겁니다. */
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform([request])
        }
    }

