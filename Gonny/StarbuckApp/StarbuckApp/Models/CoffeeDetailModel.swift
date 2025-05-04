//
//  CoffeeDetailModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/5/25.
//
//데이터의 구조만 정의해두셔
import Foundation


struct CoffeeItem: Identifiable {
    let id = UUID()
    let korName: String
    let engName: String
    let imageName: String
    let description: String
    let price: Int
    let temperature: CoffeeTemperature
    let temperatureOption: TemperatureOption
    var selectedTemperature: CoffeeTemperature
}

enum CoffeeTemperature {
    case hot
    case iced
}

enum TemperatureOption {
    case both
    case hotOnly
    case icedOnly
}
