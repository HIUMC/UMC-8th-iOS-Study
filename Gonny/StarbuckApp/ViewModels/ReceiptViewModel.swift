//
//  ReceiptViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/8/25.
//
//뷰모델에 그 뭐냐...파싱 햇을 때의 결과가 들어잇어야대
import Foundation
import SwiftData
import PhotosUI
import Vision


class ReceiptViewModel: ObservableObject {
    @Published var receipts: [Receipt] = []
    
    var modelContext: ModelContext?
    
    var totalCount: Int {
        receipts.count
    }

    var totalAmount: Int {
        receipts.reduce(0) { $0 + $1.amount }
    }

    func addReceipt(store: String, date: Date, amount: Int) {
        let receipt = Receipt(storeName: store, date: date, amount: amount)
        receipts.append(receipt)
        modelContext?.insert(receipt)
    }

    func extractText(from image: UIImage) {
        let requestHandler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        let request = VNRecognizeTextRequest { [weak self] (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            let allText = observations.compactMap { $0.topCandidates(1).first?.string }.joined(separator: "\n")
            print(" OCR 결과:\n", allText)
            
            // 예시 추출 (간단한 텍스트 파싱)
            let store = self?.extractStore(from: allText) ?? "알 수 없음"
            let date = self?.extractDate(from: allText) ?? Date()
            let amount = self?.extractAmount(from: allText) ?? 0

            DispatchQueue.main.async {
                self?.addReceipt(store: store, date: date, amount: amount)
            }
        }

        request.recognitionLanguages = ["ko-KR"]
        request.recognitionLevel = .accurate

        do {
            try requestHandler.perform([request])
        } catch {
            print("OCR 오류:", error)
        }
    }

    private func extractStore(from text: String) -> String {
        return text.components(separatedBy: .newlines).first ?? "매장명"
    }

    private func extractDate(from text: String) -> Date {
        let pattern = "\\d{4}\\.\\d{2}\\.\\d{2}"
        if let match = text.range(of: pattern, options: .regularExpression) {
            let dateString = String(text[match])
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            return formatter.date(from: dateString) ?? Date()
        }
        return Date()
    }

    private func extractAmount(from text: String) -> Int {
        let pattern = "\\d{1,3}(,\\d{3})*(?=원)"
        if let match = text.range(of: pattern, options: .regularExpression) {
            let amountStr = text[match].replacingOccurrences(of: ",", with: "")
            return Int(amountStr) ?? 0
        }
        return 0
    }
}
