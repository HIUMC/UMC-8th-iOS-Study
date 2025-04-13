//
//  ReceiptImage.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/13/25.
//

import UIKit

protocol ImageHandling: AnyObject {
    func addImage(_ image: UIImage)
    func getImages() -> [UIImage]
}
