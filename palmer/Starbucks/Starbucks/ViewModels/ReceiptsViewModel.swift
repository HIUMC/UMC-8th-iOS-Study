//
//  ReceiptViewModel.swift
//  Starbucks
//
//  Created by 박정환 on 4/8/25.
//

import SwiftUI
import Vision
import SwiftData

@Observable
class ReceiptsViewModel {
    
    //데이터 저장, 관리
    var context: ModelContext?
    
    init(context: ModelContext? = nil) {
        self.context = context
    }
    
    var currentReceipt: ReceiptsModel?
    
    func startOCR(_ receipt: ReceiptsModel) {
        guard let imageData = receipt.image?.data,    //이미지 데이터
              let uiImage = UIImage(data: imageData),
              let cgImage = uiImage.cgImage else {
            self.currentReceipt = nil
            return
        }
    
  /*var selectedSegment: ReceiptSegment = .first {
        didSet {
            startOCR(selectedSegment)
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
                
            }
        }

        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["ko-KR"]
        
        DispatchQueue.global(qos: .userInitiated).async {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform([request])
        }
    }

    private func parseWithoutRegex(from text: String, imageData: Data?) -> ReceiptsModel {
        let lines = text.components(separatedBy: .newlines)

        var store = "장소 없음"
        var totalAmount = 0
        var date = "날짜 없음"

        var i = 0

        print("===== OCR 디버그 시작 =====")

        while i < lines.count {
            let trimmed = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)
            print("🔹 [\(i)] \(trimmed)")

            // 장소
            if store == "장소 없음", trimmed.contains("점") {
                store = "스타벅스 " + trimmed
            }
            
            // 결제 시각
            if trimmed.contains("결제시간") {
                let timeLine = lines[i + 1].trimmingCharacters(in: .whitespaces)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
                if let dateObj = dateFormatter.date(from: timeLine) {
                    let formattedTime = dateFormatter.string(from: dateObj)
                    date = formattedTime
                }
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
        print("⏰ 결제 시간: \(date)")

        let imageModel = ReceiptsImage(data: imageData ?? Data())
        
        return ReceiptsModel(
            store: store,
            date: date,
            totalAmount: totalAmount,
            image: imageModel
        )
    }
    
    func addNewReceipt(from imageData: Data?) {
        let imageModel = ReceiptsImage(data: imageData ?? Data())
        let tempReceipt = ReceiptsModel(store: "", date: "", totalAmount: 0, image: imageModel)
        imageModel.receipt = tempReceipt
        startOCR(tempReceipt)
    }
    
    
    func saveReceipt(_ receipt: ReceiptsModel) {
        guard let context else { return }
        context.insert(receipt)
        try? context.save()
    }

}
