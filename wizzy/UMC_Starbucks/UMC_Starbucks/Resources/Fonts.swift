//
//  Fonts.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 3/30/25.
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
    
    /* 여기에 더 추가해주세요 */
    
    static var PretendardBold15: Font {
        return .pretend(type: .bold, size: 15)
    }
    
    static var PretendardBold22: Font {
        return .pretend(type: .bold, size: 22)
    }
    
    static var PretendardBold16: Font {
        return .pretend(type: .bold, size: 16)
    }
    
    static var PretendardBold20: Font {
        return .pretend(type: .bold, size: 20)
    }
    
    static var PretendardBold24: Font {
        return .pretend(type: .bold, size: 24)
    }
    
    static var PretendardSemiBold24: Font {
        return .pretend(type: .semibold, size: 24)
    }
    
    
    static var PretendardSemiBold16: Font {
        return .pretend(type: .semibold, size: 16)
    }
    
    static var PretendardSemiBold14: Font {
        return .pretend(type: .semibold, size: 14)
    }
    
    static var PretendardMedium16: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var PretendardMedium18: Font {
        return .pretend(type: .medium, size: 18) //생성하기 버튼
    }
    
    static var PretendardRegular18: Font {
        return .pretend(type: .regular, size: 18)
    }
    
    static var PretendardRegular13: Font {
        return .pretend(type: .regular, size: 13)
    }
    
    static var PretendardRegular12: Font {
        return .pretend(type: .regular, size: 12)
    }
    
    static var PretendardRegular09: Font {
        return .pretend(type: .regular, size: 09)
    }
    
    static var PretendardLight14: Font {
        return .pretend(type: .light, size: 14)
    }
    
    static var PretendardExtraBold24: Font {
        return .pretend(type: .extraBold, size: 24)
    }
    
    static var PretendardSemiBold38: Font {
        return .pretend(type: .semibold, size: 38)
    }
    
    static var PretendardSemiBold13: Font {
        return .pretend(type: .semibold, size: 13)
    }
    
    static var PretendardSemiBold12: Font {
        return .pretend(type: .semibold, size: 12)
    }
    
    static var PretendardSemiBold18: Font {
        return .pretend(type: .semibold, size: 18)
    }
    
    
    static var PretendardLight24: Font {
        return .pretend(type: .light, size: 24)
    }
    
    
    
    
}
