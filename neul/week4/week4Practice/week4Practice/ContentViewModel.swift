//
//  ContentViewModel.swift
//  week4Practice
//
//  Created by tokkislove on 4/7/25.
//

import Foundation
import SwiftUI

@Observable
class ContentViewModel: ExImageHandling {
    
    func addImage(_ images: UIImage) {
        self.images.append(images)
    }
    
    func removeImage(at index: Int) {
        guard !self.images.isEmpty else { return }
        self.images.remove(at: index)
    }
    
    func getImages() -> [UIImage] {
        self.images
    }
    
    var isImagePickerPresented: Bool = false
    
    internal var images: [UIImage] = []
    
}
