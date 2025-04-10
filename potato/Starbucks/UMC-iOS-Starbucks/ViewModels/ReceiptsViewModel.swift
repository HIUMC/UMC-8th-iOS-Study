//
//  OCRViewModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/8/25.
//

import Foundation
import UIKit
import Vision

@Observable
class ReceiptsViewModel {
    var currentReceipt: ReceiptsModel?

    func performOCR(on uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else {
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
            
            let recognizedString = observations.compactMap { $0.topCandidates(1).first?.string}
            let fullText = recognizedString.joined(separator: "\n")
            let parsed = self.parseWithoutRegex(from: fullText)
            
            // ReceiptModel 생성할 때 이미지도 같이 저장 -> 이래야 dollar 표시 눌렀을 때 영수증 이미지를 불러올 수 있다
            parsed.image = uiImage.pngData()
            
            DispatchQueue.main.async {
                self.currentReceipt = parsed
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
    
    private func parseWithoutRegex(from text: String) -> ReceiptsModel {
        let lines = text.components(separatedBy: .newlines)
        
        var store = "장소 없음"
        var totalAmount = 0
        var date = "날짜 없음"
        
        var i = 0
        
        print("===== OCR 디버그 시작 =====")
        while i < lines.count {
            let trimmed = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)
            print("🔹 [\(i)] \(trimmed)")
            
            // 날짜
            if trimmed.contains("201-81-21515") {
                date = lines[i + 1].trimmingCharacters(in: .whitespaces)
            }
            
            // 장소
            if store == "장소 없음", trimmed.contains("점") {
                store = "스타벅스 " + trimmed
            }
            
            // 결제 금액
            if trimmed.contains("결제금액"), i + 2 < lines.count {
                let priceLine = lines[i + 2].trimmingCharacters(in: .whitespaces)
                let numberOnly = priceLine.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if let amount = Int(numberOnly) {
                    totalAmount = amount
                }
            }
        
            i += 1
        }
        
        print("===== OCR 디버그 끝 =====")
        print("🏪 매장명: \(store)")
        print("💰 결제 금액: \(totalAmount)")
        print("🗓️ 날짜: \(date)")
        
        return ReceiptsModel(store: store, totalAmount: totalAmount, date: date)
    }
}
