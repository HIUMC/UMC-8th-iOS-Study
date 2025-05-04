//
//  ImageHandling.swift
//  2025-UMC-iOS
//
//  Created by 이효주 on 4/10/25.
//

import UIKit

protocol ImageHandling: AnyObject {
    func addImage(_ image: UIImage)
    func getImages() -> [UIImage]
    var recognizedText: String { get set }
}
