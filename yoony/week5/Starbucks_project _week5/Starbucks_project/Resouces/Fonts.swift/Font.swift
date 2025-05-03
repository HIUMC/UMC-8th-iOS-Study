//
//  FontManager.swift
//  Starbucks_project
//
//  Created by Yoonseo on 3/20/25.
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
    
    static var PretendardBold30: Font {
        return .pretend(type: .bold, size: 30)
    }
    
    static var PretendardLight16: Font {
        return .pretend(type: .light, size: 16)
    }
    
    static var PretendardBold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    
    static var PretendardBold18: Font {
        return .pretend(type: .bold, size: 18)
    }
    
    static var PretendardSemiBold18: Font {
        return .pretend(type: .semibold, size: 18)
    }
    
    static var PretendardSemiBold24: Font {
        return .pretend(type: .semibold, size: 24)
    }
    
    static var PretendardSemiBold22: Font {
        return .pretend(type: .semibold, size: 22)
    }
    
    static var mainTextSemiBold24: Font {
        return .pretend(type: .semibold, size: 24)
    }
    
    static var mainTextSemiBold22: Font {
        return .pretend(type: .semibold, size: 22)
    }
    
    static var mainTextSemiBold14: Font {
        return .pretend(type: .semibold, size: 14)
    }
    
    static var mainTextSemiBold13: Font {
        return .pretend(type: .semibold, size: 13)
    }
    
    static var mainTextSemiBold16: Font {
        return .pretend(type: .semibold, size: 16)
    }
    
    static var mainTextSemiBold38: Font {
        return .pretend(type: .semibold, size:38)
    }
    
    static var mainTextBold20: Font {
        return .pretend(type: .bold, size: 20)
    }
    
    static var mainTextBold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    
    static var mainTextExtraBold24: Font {
        return .pretend(type: .extraBold, size: 24)
    }
    
    static var mainTextMedium16: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var mainTextRegular13: Font {
        return .pretend(type: .regular, size: 13)
    }
    
    static var mainTextRegular18: Font {
        return .pretend(type: .regular, size: 18)
    }
    
    static var mainTextRegular12: Font {
        return .pretend(type: .regular, size: 12)
    }
    
    static var mainTextRegular9: Font {
        return .pretend(type: .regular, size: 9)
    }
    
    
    static var mainTextRegular14: Font {
        return .pretend(type: .regular, size: 14)
    }

}
