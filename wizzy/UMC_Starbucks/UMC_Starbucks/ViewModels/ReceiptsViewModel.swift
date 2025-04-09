//
//  ReceiptsViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/8/25.
//
/*

import Foundation
import SwiftUI
import Vision

@Observable
class ReceiptsViewModel {
    
    
    @Published var segments: [ReceiptSegment] = [
            ReceiptSegment(title: "첫 번째", imageName: "first")]
    
    @Published var selectedSegment: ReceiptSegment
    @Published var currentReceipt: ReceiptsModel? = nil

    init() {
            // 초기값으로 첫 번째 세그먼트를 선택
            self.selectedSegment = segments.first! //segments라는 배열의 첫 번째 요소를 가져옴
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

            request.recognitionLevel = VNRequestTextRecognitionLevel.accurate
            request.recognitionLanguages = ["ko-KR"]
            
            /* 이 부분을 DispatchQueue를 삭제하거나 우선순위를 바꿔가며 한 번 돌려보세요! 다른 경험을 보게 될 겁니다. */
            DispatchQueue.global(qos: .userInitiated).async {
                let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                try? handler.perform([request])
            }
        }
}
*/
