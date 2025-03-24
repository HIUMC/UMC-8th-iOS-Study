//
//  Fonts.swift
//  Starbucks
//
//  Created by 이가원 on 3/24/25.
//
import SwiftUI

extension Font {
    enum Pretendard {
        case extraBold
        case bold
        case semiBold
        case medium
        case regular
        case light
        case custom(String)
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semiBold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            case .custom(let name):
                return name
            }
        }
    }
    
    static func pretendard(_ type: Pretendard, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
}
