//
//  PayModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 6/19/25.
//
import SwiftUI
import SwiftData

//PayView에서 카드 유효기간 보여줄 때 사용할 모델
struct Card: Identifiable, Equatable {
    let id = UUID()
    let imageName: String
    let name: String
    let price: Int
    let cardNumber: String
    let money: Int?
    let initialSeconds: Int // 3*60 (초단위)
    var remainingSeconds: Int // 남은 시간 (초단위)
}
