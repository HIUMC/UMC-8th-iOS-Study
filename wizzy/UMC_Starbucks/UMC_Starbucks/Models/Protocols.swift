//
//  Protocols.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/8/25.
//

import Foundation
import UIKit

protocol ImageHandling: AnyObject {
    func addImage(_ image: UIImage)
    func getImages() -> [UIImage]
    var recognizedText: String { get set }
}
