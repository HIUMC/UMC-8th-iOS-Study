//
//  Fonts.swift
//  Starbucks_App_
//
//  Created by 김지우 on 3/20/25.
//

import Foundation
import SwiftUI

extension Font{
    enum Pretendard {
        case Black, Bold, ExtraBold, ExtraLight, Light, Medium, Regular, SemiBold, Thin
        case custom(String)
        
        var value: String {
            switch self {
            case .Black: return "Pretendard-Black" //return에는 폰트 풀네임 써줘야함!! 아니면 나중에 폰트가 적용이 안됨
            case .Bold: return "Pretendard-Bold"
            case .ExtraBold: return "Pretendard-ExtraBold"
            case .ExtraLight: return "Pretendard-ExtraLight"
            case .Light: return "Pretendard-Light"
            case .Medium: return "Pretendard-Medium"
            case .Regular: return "Pretendard-Regular"
            case .SemiBold: return "Pretendard-SemiBold"
            case .Thin: return "Pretendard-Thin"
            case .custom(let name): return name
            }
        }
    }
    
    static func pretend(type: Pretendard, size: CGFloat) -> Font {
            return .custom(type.value, size: size)
        }
        
        static var PretendardExtraBold24: Font {
            return .pretend(type: .ExtraBold, size: 24)
        }
    
        
        static var PretendardMedium16: Font {
            return .pretend(type: .Medium, size: 16)
        }
    
    static var PretendardMedium18: Font {
        return .pretend(type: .Medium, size: 18)
    }
        
        static var PretendardRegular12: Font {
            return .pretend(type: .Regular, size: 12)
        }
        
        static var PretendardRegular13: Font {
            return .pretend(type: .Regular, size: 13)
        }
    static var PretendardSemiBold24: Font {
        return .pretend(type: .SemiBold, size: 24)
    }
    
    static var PretendardSemiBold16: Font {
        return .pretend(type: .SemiBold, size: 16)
    }
    
    static var PretendardRegular24: Font {
        return .pretend(type: .Regular, size: 24)
    }
    static var PretendardRegular18: Font {
        return .pretend(type: .Regular, size: 18)
    }

   
    
    }



