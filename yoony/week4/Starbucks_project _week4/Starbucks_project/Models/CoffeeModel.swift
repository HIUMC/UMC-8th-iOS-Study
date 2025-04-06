//
//  CoffeeModel.swift
//  Starbucks_project
//
//  Created by Yoonseo on 4/3/25.
//


import Foundation
import SwiftUI

enum CoffeeType: String, CaseIterable {
    case iced = "ICED"
    case hot = "HOT"
}


struct Coffee: Identifiable {
    let id = UUID()
    let name: String
    let englishName: String
    let description: String
    let price: Int
    let image: String
    let availableType: [CoffeeType]
}
    

enum CoffeeinfoModel: CaseIterable {
    case IcedcaramelMacchiato
    case CaramelMacchiato
    case IcedCafeAmericano
    case CafeAmericano
    case EspressoConPanna
    case EspressoMacchiato
}

/*
func returnCoffee() -> Coffee {
    switch self {
        
    case .IcedCaramelMacchiato:
        return Coffee.IcedCaramelMacchiato
    case .CaramelMacchiato:
        return Coffee.CaramelMacchiato
    case .IcedCafeAmericano:
        return Coffee.IcedCafeAmericano
    case .CafeAmericano:
        return Coffee.CafeAmericano
    case .EspressoConPanna:
        return Coffee.EspressoConPanna
    case .EspressoMacchiato:
        return Coffee.EspressoMacchiato
    
        
        
    }
}
*/
