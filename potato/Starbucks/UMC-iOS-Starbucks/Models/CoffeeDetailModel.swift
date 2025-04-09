//
//  CoffeeDetailModel.swift
//  UMC-iOS-Starbucks
//
//  Created by 곽은채 on 4/3/25.
//

import Foundation

enum CoffeeDetailModel: CaseIterable {
    case confanaa
    case macchiato
    case iceAmericano
    case americano
    case iceCaramelMacchiato
    case caramelMacchiato
    
    static func from(coffee: CoffeeModel) -> CoffeeDetailModel? {
        switch coffee.name {
        case "에스프레소 콘파나":
            return .confanaa
        case "에스프레소 마키아또":
            return .macchiato
        case "아이스 카페 아메리카노":
            return .iceAmericano
        case "카페 아메리카노":
            return .americano
        case "아이스 카라멜 마키아또":
            return .iceCaramelMacchiato
        case "카라멜 마키아또":
            return .caramelMacchiato
        default:
            return nil
        }
    }
    
    func returnCoffeeImg() -> String {
        switch self {
        case .confanaa:
            return "confanaaD"
        case .macchiato:
            return "macchiatoD"
        case .iceAmericano:
            return "iceAmericanoD"
        case .americano:
            return "americanoD"
        case .iceCaramelMacchiato:
            return "iceCaramelD"
        case .caramelMacchiato:
            return "caramelD"
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
    
    func returnCoffeeNameEng() -> String {
        switch self {
        case .confanaa:
            return "Espresso Con Panna"
        case .macchiato:
            return "Espresso Macchiato"
        case .iceAmericano:
            return "Iced Caffe Americano"
        case .americano:
            return "Caffe Americano"
        case .iceCaramelMacchiato:
            return "Iced Caramel Macchiato"
        case .caramelMacchiato:
            return "Caramel Macchiato"
        }
    }
    
    func returnCoffeeDetail() -> String {
        switch self {
        case .confanaa:
            return "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료"
        case .macchiato:
            return "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료"
        case .iceAmericano:
            return "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피"
        case .americano:
            return "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피"
        case .iceCaramelMacchiato:
            return "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료"
        case .caramelMacchiato:
            return "향긋한 바닐라 시럽과 따뜻한 스팀 밀크 위에 풍성한 우유 거품을 얹고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료"
        }
    }

    func returnCoffeePrice() -> String {
        switch self {
        case .confanaa:
            return "4,100원"
        case .macchiato:
            return "3,900원"
        case .iceAmericano:
            return "4,700원"
        case .americano:
            return "4,700원"
        case .iceCaramelMacchiato:
            return "6,100원"
        case .caramelMacchiato:
            return "6,100원"
        }
    }
    
    func returnCoffeeType() -> [CoffeeType] {
        switch self {
        case .confanaa:
            return [.hot]
        case .macchiato:
            return [.ice]
        case .americano, .iceAmericano, .caramelMacchiato, .iceCaramelMacchiato:
            return [.hot, .ice]
        }
    }
}

enum CoffeeType: String {
    case ice = "ICED"
    case hot = "HOT"
}
