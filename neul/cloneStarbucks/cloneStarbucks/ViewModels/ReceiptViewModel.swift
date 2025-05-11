//
//  ReceiptViewModel.swift
//  cloneStarbucks
//
//  Created by tokkislove on 4/8/25.
//

import SwiftUI
import Vision
import SwiftData

@Observable
class ReceiptViewModel {
    
    var context: ModelContext?
    

    
    init(context: ModelContext? = nil) {
        self.context = context
    }
    
    var currentReceipt: ReceiptModel?
    
    func startOCR(_ receipt: ReceiptModel) {
        guard let imageData = receipt.image?.data,
              let uiImage = UIImage(data: imageData),
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
            let parsed = self.parseWithoutRegex(from: fullText, imageData: imageData)
            
            DispatchQueue.main.async {
                self.currentReceipt = parsed
                self.saveReceipt(parsed)
            }
        }
        
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR"]
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform([request])
        }
        
    }
    
    
    private func parseWithoutRegex(from text: String, imageData: Data?) -> ReceiptModel {
        let lines = text.components(separatedBy: .newlines)
        
        var store = "장소 없음"
        var date = "날짜 없음"
        var totalAmount = 0
        
        let timeRegex = try! NSRegularExpression(pattern: "\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")
        var i = 0
        
        print("===== OCR 디버그 시작 =====")
        
        while i < lines.count {
            let trimmed = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)
            print("🔹 [\(i)] \(trimmed)")
            
            // 장소
            if store == "장소 없음", trimmed.contains(where: {["점", "역"].contains(String($0))  }) {
                store = "스타벅스 " + trimmed
            }
            
            // 결제 시각
            let range = NSRange(location: 0, length: trimmed.utf16.count)
            if let match = timeRegex.firstMatch(in: trimmed, range: range) {
                let matched = (trimmed as NSString).substring(with: match.range)
                
                // 문자열 → Date
                let inputFormatter = DateFormatter()
                inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                inputFormatter.locale = Locale(identifier: "ko_KR")
                
                if let finalDate = inputFormatter.date(from: matched) {
                    // 원하는 출력 포맷
                    let outputFormatter = DateFormatter()
                    outputFormatter.dateFormat = "yyyy.MM.dd HH:mm"
                    outputFormatter.locale = Locale(identifier: "ko_KR")
                    date = outputFormatter.string(from: finalDate)
                } else {
                    date = matched // fallback
                }
            }
            
            
            // 결제 금액
            if trimmed.contains("승인금액"), i + 3 < lines.count {
                let priceLine = lines[i + 3].trimmingCharacters(in: .whitespaces)
                let numberOnly = priceLine.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if let amount = Int(numberOnly) {
                    totalAmount = amount
                }
            }
            
            i += 1
        }
        
        print("===== OCR 디버그 끝 =====")
        print("🏪 매장명: \(store)")
        print("📆 날짜: \(date)")
        print("💰 결제 금액: \(totalAmount)")

        let imageModel = ReceiptImage(data: imageData ?? Data())
        let receipt = ReceiptModel(
            store: store,
            date: date,
            totalAmount: totalAmount,
            image: imageModel
        )
        imageModel.receipt = receipt

        return receipt
    }

    
    func addNewReceipt(from imageData: Data?) {
        let imageModel = ReceiptImage(data: imageData ?? Data())
        let tempReceipt = ReceiptModel(store: "", date: "", totalAmount: 0, image: imageModel)
        imageModel.receipt = tempReceipt
        startOCR(tempReceipt)
    }
    
    
    func saveReceipt(_ receipt: ReceiptModel) {
        guard let context else { return }
        context.insert(receipt)
        try? context.save()
    }
    
    
}
