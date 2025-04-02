//
//  CoffeeModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/1/25.
//

import Foundation

enum CoffeeModel: CaseIterable {
    case confanaa
    case macchiato
    case iceAmericano
    case americano
    case iceCaramelMacchiato
    case caramelMacchiato
    
    var id : UUID {
        switch self {
        case .confanaa:
            return UUID()
        case .macchiato:
            return UUID()
        case .iceAmericano:
            return UUID()
        case .americano:
            return UUID()
        case .iceCaramelMacchiato:
            return UUID()
        case .caramelMacchiato:
            return UUID()
        }
    }
    
    func returnCoffeeImg() -> String {
        switch self {
        case .confanaa:
            return "confanaa"
        case .macchiato:
            return "macchiato"
        case .iceAmericano:
            return "iceAmericano"
        case .americano:
            return "americano"
        case .iceCaramelMacchiato:
            return "iceCaramel"
        case .caramelMacchiato:
            return "caramel"
        }
    }
    
    func returnCoffeeName() -> String {
        switch self {
        case .confanaa:
            return "에스프레소 콘파나"
        case .macchiato:
            return "에스프레소 마키아또"
        case .iceAmericano:
            return "아이스 카페 아메리카노"
        case .americano:
            return "카페 아메리카노"
        case .iceCaramelMacchiato:
            return "아이스 카라멜 마키아또"
        case .caramelMacchiato:
            return "카라멜 마키아또"
        }
    }
}
