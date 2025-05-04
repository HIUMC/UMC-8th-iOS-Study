//
//  OCRViewModel.swift
//  Starbucks
//
//  Created by nau on 4/8/25.
//

import SwiftUI
import Vision
import UIKit

protocol ImageHandling: AnyObject {
    func addImage(_ image: UIImage)
    func getImages() -> [UIImage]
    var recognizedText: String { get set }
}

@Observable
class OCRViewModel: ImageHandling {
    
    var images: [UIImage] = []
    var recognizedText: String = ""
    
    var currentReceipts: [ReceiptModel] = [] // 배열로 받아서 영수증 여러개를 받을 수 있도록..
    
    //view에서 @State로 했더니 안됨.. 이유가 뭐지?
    var selectedReceiptImage: UIImage?
    
    // 합계 가격
    var sum : Int = 0
    
    // 영수증 총 개수
    var receiptCount: Int {
        return currentReceipts.count
    }
    
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
                let receipt = self?.parseWithoutRegex(from: self?.recognizedText ?? "") // 코드 추가..
                if let newReceipt = receipt {
                    self?.currentReceipts.append(newReceipt)
                    self?.sum += receipt!.totalAmount // 합계 가격
                }
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
    
    private func parseWithoutRegex(from text: String) -> ReceiptModel {
        let lines = text.components(separatedBy: .newlines)
        
        var store = "장소 없음"
        var totalAmount = 0
        var date: String = "날짜 없음"
        
        var i = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss" //"2025.01.05 11:30 형식의 날짜 포맷"
        
        let outDateFormatter = DateFormatter()
        outDateFormatter.dateFormat = "yyyy.MM.dd HH:mm" //초를 뺀 날짜 형식
        
        let dateRegex = "\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"
        print("===== OCR 디버그 시작 =====")
        
        while i < lines.count {
            let trimmed = lines[i].trimmingCharacters(in: .whitespacesAndNewlines)
            print("🔹 [\(i)] \(trimmed)")
            
            // 장소. 피그마 영수증에선 i가 4일때 나오는데 대충 인덱스 6안에서 점이나 정 포함된거 뽑아냄.. 화질 안좋아서 사당역점의 점이 정으로 인식됨
            if store == "장소 없음", i < 6, trimmed.contains("점") || trimmed.contains("정") ||  trimmed.contains("전") {
                store = trimmed
                if store.count > 1 {
                    store = String(store.dropLast())
                }
            }
            
            // 결제 금액
            if trimmed.contains("세") || trimmed.contains("Total") || trimmed.contains("주문번호"), i + 1 < lines.count {
                let priceLine = lines[i + 1].trimmingCharacters(in: .whitespaces)
                let numberOnly = priceLine.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                if let amount = Int(numberOnly) {
                    totalAmount = amount
                }
            }
            
            if date == "날짜 없음", let dateRange = trimmed.range(of: dateRegex, options: .regularExpression) {
                let dateString = String(trimmed[dateRange])
                if let parseDate = dateFormatter.date(from: dateString) {
                    date = outDateFormatter.string(from: parseDate)
                }
            }
            
            i += 1
        }
        
        print("===== OCR 디버그 끝 =====")
        print("🏪 매장명: \(store)")
        print("💰 결제 금액: \(totalAmount)")
        print("주문 날짜: \(date)")
        
        
        return ReceiptModel(
            store: store,
            totalAmount: totalAmount,
            date: date,
            receiptImage: images.last! //이미지
        )
    }
}
