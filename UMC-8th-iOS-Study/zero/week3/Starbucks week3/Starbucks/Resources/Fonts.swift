//
//  Fonts.swift
//  Starbucks
//
//  Created by 김영택 on 3/21/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case extrabold
        case bold
        case semibold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .extrabold:
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
    
    static var PretendardSemibold38: Font {
        return .pretend(type: .semibold, size: 38)
    }
    
    static var PretendardRegular24: Font {
        return .pretend(type: .regular, size: 24)
    }
    
    static var PretendardExtrabold24: Font {
        return .pretend(type: .extrabold, size: 24)
    }
    
    static var PretendardSemibold24: Font {
        return .pretend(type: .semibold, size: 24)
    }
    
    static var PretendardSemibold16: Font {
        return .pretend(type: .semibold, size: 16)
    }
    
    static var PretendardSemibold18: Font {
        return .pretend(type: .semibold, size: 18)
    }
    
    static var PretendardSemibold14: Font {
        return .pretend(type: .semibold, size: 14)
    }
    
    static var PretendardSemibold13: Font {
        return .pretend(type: .semibold, size: 13)
    }
    
    static var PretendarMedium16: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var PretendardRegular13: Font {
        return .pretend(type: .regular, size: 13)
    }
    
    static var PretendardRegular12: Font {
        return .pretend(type: .regular, size: 12)
    }
    
    static var PretendardLight24: Font {
        return .pretend(type: .light, size: 24)
    }
    
    static var PretendardBold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    
    static var PretendardBold22: Font {
        return .pretend(type: .bold, size: 22)
    }
    
    static var PretendardBold16: Font {
        return .pretend(type: .bold, size: 16)
    }
}

