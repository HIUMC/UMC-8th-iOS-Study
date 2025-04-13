//
//  ReciptsViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/13/25.
//

import Foundation
import SwiftUI
import Vision

@Observable
class ReceiptsViewModel {
    var selectedSegment: ReceiptSegment = .first {
        didSet {
            startOCR(selectedSegment)
        }
    }
    
    var currentReceipt: ReceiptsModel?
    
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
            
        }
        
        
        
    }
}
