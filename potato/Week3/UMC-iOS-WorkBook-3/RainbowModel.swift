//
//  RainbowModel.swift
//  UMC-iOS-WorkBook-3
//
//  Created by 곽은채 on 3/31/25.
//

import Foundation
import SwiftUI

enum RainbowModel: CaseIterable {
    case red
    case orange
    case yellow
    case green
    case blue
    case indigo
    case purple
    
    func returnColor() -> Color {
        switch self {
        case .red:
            return Color.rainbowRed
        case .orange:
            return Color.rainbowOrange
        case .yellow:
            return Color.rainbowYellow
        case .green:
            return Color.rainbowGreen
        case .blue:
            return Color.rainbowBlue
        case .indigo:
            return Color.rainbowIndigo
        case .purple:
            return Color.rainbowPurple
        }
    }
    
    func returnColorName() -> String {
        switch self {
        case .red:
            return "빨강"
        case .orange:
            return "오렌지"
        case .yellow:
            return "노랑"
        case .green:
            return "초록"
        case .blue:
            return "파랑"
        case .indigo:
            return "남색"
        case .purple:
            return "보라"
        }
    }
}
