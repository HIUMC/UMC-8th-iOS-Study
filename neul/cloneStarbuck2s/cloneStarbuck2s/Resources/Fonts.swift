//
//  Fonts.swift
//  cloneStarbucks
//
//  Created by tokkislove on 3/22/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case black
        case extraBold
        case bold
        case extraLight
        case semibold
        case medium
        case regular
        case light
        case thin
        
        var value: String {
            switch self {
            case .black:
                return "Pretendard-Black"
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .extraLight:
                return "Pretendard-ExtraLight"
            case .semibold:
                return "Pretendard-SemiBold"
            case .medium:
                return "Pretendard-Medium"
            case .regular:
                return "Pretendard-Regular"
            case .light:
                return "Pretendard-Light"
            case .thin:
                return "Pretendard-Thin"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static var MainTextBold20: Font {
        return .pretend(type: .bold, size: 20)
    }
    
    static var MainTextBold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    
    static var MainTextSemiBold38: Font {
        return .pretend(type: .semibold, size: 38)
    }
    
    static var MainTextSemiBold24: Font {
        return .pretend(type: .semibold, size: 24)
    }
    
    static var MainTextSemiBold18: Font {
        return .pretend(type: .semibold, size: 18)
    }
    
    static var MainTextSemiBold16: Font {
        return .pretend(type: .semibold, size: 16)
    }
    
    static var MainTextSemiBold14: Font {
        return .pretend(type: .semibold, size: 14)
    }
    
    static var MainTextSemiBold13: Font {
        return .pretend(type: .semibold, size: 13)
    }
    
    static var MainTextMedium16: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var MainTextRegular18: Font {
        return .pretend(type: .regular, size: 18)
    }
    
    static var MainTextRegular13: Font {
        return .pretend(type: .regular, size: 13)
    }
    
    static var MainTextRegular12: Font {
        return .pretend(type: .regular, size: 12)
    }
    
    static var MainTextRegular09: Font {
        return .pretend(type: .regular, size: 9)
    }
    
    static var MainTextLight14: Font {
        return .pretend(type: .light, size: 14)
    }
    
    static var MainTextExtraBold24: Font {
        return .pretend(type: .extraBold, size: 24)
    }

    static var MakeMedium18: Font {
        return .pretend(type: .medium, size: 18)
    }
    
}

