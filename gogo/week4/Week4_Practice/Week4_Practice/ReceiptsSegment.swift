//
//  ReceiptsSegment.swift
//  Week4_Practice
//
//  Created by 고석현 on 4/22/25.
//

import Foundation // 기본적인 Swift 기능들을 사용하기 위해 Foundation 모듈을 불러옴

// 영수증 구간을 구분하기 위한 열거형(enum) 정의
enum ReceiptSegment: Int, CaseIterable, Identifiable {
    case first   // 첫 번째 영수증
    case second  // 두 번째 영수증
    
    // ✅ Identifiable 프로토콜을 만족시키기 위한 id 정의
    // 각 case의 rawValue(Int 값)를 그대로 id로 사용 --> first는 0, second 은 1
    var id: Int { rawValue }
    
    // ✅ 영수증 구간에 따라 보여줄 제목(텍스트)을 반환하는 **계산 속성**
    var title: String {
        // 🔸 switch self: 여기서 self는 현재 enum 인스턴스 (예: .first 또는 .second)
        // → 즉, 현재 값이 .first냐 .second냐에 따라 결과를 다르게 반환하겠다는 의미
        switch self {
        case .first:
            return "첫 번째"   // self가 .first일 때
        case .second:
            return "두 번째"  // self가 .second일 때
        }
    }
    
    // ✅ 해당 영수증에 대응되는 이미지 이름을 반환하는 **계산 속성**
    var imageName: String {
        // 마찬가지로 현재 enum 값(self)에 따라 다른 이미지 이름을 반환
        switch self {
        case .first:
            return "first"
        case .second:
            return "second"
        }
    }
}
