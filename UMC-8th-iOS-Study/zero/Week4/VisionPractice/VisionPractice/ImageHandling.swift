//
//  ImageHandling.swift
//  VisionPractice
//
//  Created by 김영택 on 4/10/25.
//

import UIKit

protocol ImageHandling: AnyObject {
    func addImage(_ image: UIImage)
    func getImages() -> [UIImage]
    var recognizedText: String { get set }
}
