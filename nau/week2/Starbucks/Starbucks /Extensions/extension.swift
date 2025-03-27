//
//  extension.swift
//  Starbucks
//
//  Created by nau on 3/26/25.
//

import Foundation
import UIKit

//화면 크기
extension UIScreen {
    static var screenSize: CGRect {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return windowScene.screen.bounds
    }
}

