//
//  Fonts.swift
//  Starbucks
//
//  Created by nau on 3/18/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case extraBold
        case bold
        case semibold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "Pretendard-ExtraBold"
            case .bold:
                return "Pretendard-Bold"
            case .semibold:
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
    
    static var mainTextExtraBold24: Font {
        return .pretend(type: .extraBold, size: 24)
    }
    
    static var mainTextBold20: Font {
        return .pretend(type: .bold, size: 20)
    }
    
    static var mainTextSemiBold18: Font {
        return .pretend(type: .semibold, size: 18)
    }
    
    static var mainTextMedium16: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var mainTextRegular13: Font {
        return .pretend(type: .regular, size: 13)
    }
    
    static var mainTextRegular12: Font {
        return .pretend(type: .regular, size: 12)
    }
    
    //피그마에선 mainText18_Regular로 나와있지만 내가 임의로 바꿈..
    static var mainTextRegular18: Font {
        return .pretend(type: .regular, size: 18)
    }
    
    static var mainTextBold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    
    static var mainTextRegular24: Font {
        return .pretend(type: .regular, size: 24)
    }
    
    static var mainTextSemibold24: Font {
        return .pretend(type: .semibold, size: 24)
    }
    
    static var mainTextSemibold16: Font {
        return .pretend(type: .semibold, size: 16)
    }
    
    static var mainTextLight14: Font {
        return .pretend(type: .light, size: 14)
    }
    
    static var makeMedium18: Font {
        return .pretend(type: .medium, size: 18)
    }
}
