//
//  OCRViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/8/25.
//

import SwiftUI
import Vision

@Observable
class OCRViewModel: ImageHandling {
    var images: [UIImage] = []
    var recognizedText: String = ""

    var currentReceipt: ReceiptsModel?
    
    
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
                self?.currentReceipt = self?.parseWithoutRegex(from: self!.recognizedText) // 추가!!!!
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
    
    private func parseWithoutRegex(from text: String) -> ReceiptsModel { // 추가!!!!
        let lines = text.components(separatedBy: .newlines)

        var orderer = "주문자 없음"
        var store = "장소 없음"
        var menuItems: [String] = []
        var totalAmount = 0
        var orderNumber = "주문번호 없음"

        var isMenuSection = false
        var i = 0

        while i < lines.count {
            let trimmed = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)

            // 주문자
            if trimmed.range(of: #"\([A-Z]-\s*\d+\)"#, options: .regularExpression) != nil {
                orderer = trimmed.components(separatedBy: " ").first ?? "주문자 없음"
                isMenuSection = true
                i += 1
                continue
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

            // 주문번호
            if trimmed.starts(with: "32"),
               trimmed.count >= 14,
               trimmed.allSatisfy({ $0.isNumber }) {
                orderNumber = trimmed
            }

            // 메뉴 종료
            if trimmed.contains("합계") || trimmed.contains("결제금액") {
                isMenuSection = false
            }

            // 음료 인식: T 포함 줄
            if isMenuSection,
               trimmed.contains("T"),
               !trimmed.hasPrefix("L"),
               !trimmed.contains("할인"),
               !trimmed.contains("데움") {
                let cleanName = trimmed.components(separatedBy: ")").last?.trimmingCharacters(in: .whitespaces) ?? trimmed
                menuItems.append(cleanName)
            }

            i += 1
        }

        return ReceiptsModel(
            orderer: orderer,
            store: store,
            menuItems: menuItems,
            totalAmount: totalAmount,
            orderNumber: orderNumber
        )
    }
}
