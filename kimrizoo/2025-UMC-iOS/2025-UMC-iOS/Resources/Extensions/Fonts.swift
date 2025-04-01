//
//  Fonts.swift
//  2025-UMC-1week-practice
//
//  Created by 이효주 on 3/20/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case extraBold
        case bold
        case semiBold
        case medium
        case regular
        case light
        
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
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var PretendardExtraBold24: Font {
        return .pretend(type: .extraBold, size: 24)
    }
    
    static var PretendardMedium16: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var PretendardRegular12: Font {
        return .pretend(type: .regular, size: 12)
    }
    
    static var PretendardRegular13: Font {
        return .pretend(type: .regular, size: 13)
    }
    
    static func PretendardMedium(size: CGFloat) -> Font {
        return .pretend(type: .medium, size: size)
    }
    
    static func customPretend(_ type: Pretend, size: CGFloat) -> Font {
            return .custom(type.value, size: size)
    }
}
