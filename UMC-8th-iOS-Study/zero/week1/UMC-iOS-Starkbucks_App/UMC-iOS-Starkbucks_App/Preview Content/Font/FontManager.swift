//
//  FontManager.swift
//  UMC-iOS-Starkbucks_App
//
//  Created by 김영택 on 3/20/25.
//



import SwiftUI

enum Pretendard {
    case Black, Bold, ExtraBold, ExtraLight, Light, Medium, Regular, SemiBold, Thin
    case custom(String)

    var value: String {
        switch self {
        case .Black: return "Black"
        case .Bold: return "Bold"
        case .ExtraBold: return "ExtraBold"
        case .ExtraLight: return "ExtraLight"
        case .Light: return "Light"
        case .Medium: return "Medium"
        case .Regular: return "Regular"
        case .SemiBold: return "SemiBold"
        case .Thin: return "Thin"
        case .custom(let name): return name
        }
    }
}

extension Font {
    static func Pretendard(_ type: Pretendard, size: CGFloat = 17) -> Font {
        return .custom(type.value, size: size)
    }
}
