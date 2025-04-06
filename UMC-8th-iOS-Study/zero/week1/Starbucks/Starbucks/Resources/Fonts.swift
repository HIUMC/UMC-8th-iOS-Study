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
    
    static var PretendarMedium16: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var PretendardRegular13: Font {
        return .pretend(type: .regular, size: 13)
    }
    
    static var PretendardRegular12: Font {
        return .pretend(type: .regular, size: 12)
    }
}

