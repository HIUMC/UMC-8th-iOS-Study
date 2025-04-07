//
//  ImageHandlingProtocol.swift
//  week4Practice
//
//  Created by tokkislove on 4/7/25.
//

import UIKit

protocol ImageHandling: AnyObject {
    func addImage(_ image: UIImage)
    func getImages() -> [UIImage]
    var recognizedText: String { get set }
}

