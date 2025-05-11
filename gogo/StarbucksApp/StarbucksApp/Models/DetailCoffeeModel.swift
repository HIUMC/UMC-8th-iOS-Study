//
//  DetailCoffeeModel.swift
//  StarbucksApp
//
//  Created by 고석현 on 4/9/25.
//
////내 머리루 도저히 안되구리
import SwiftUI
////단순 배열이 아닌 구조체이므로 Identifiable 프로토콜 사용 -> ForEach 구문 사용 가능 및 순회 가능.
struct DetailCoffeeModel: Identifiable {
    let id = UUID()
    var name: String
    var nameEn: String
    var Image: Image
    var content: String
    var price: String
    var temperature: Temp
    var hasBothTemps: Bool
    //Temp 열거형 선언
//CaseIterable 프로토콜 채택 -> 열거형의 모든 케이스를 배열처럼 반환 가능(모든 케이스 순회에 유용~)
    
    enum Temp: String, CaseIterable,Equatable {
        case iced = "ICED"
        case hot = "HOT"
    }
}
