//
//  CoffeeViewModel.swift
//  Starbucks
//
//  Created by 이가원 on 4/5/25.
//
import SwiftUI
import Foundation

class CoffeeViewModel: ObservableObject {
    @Published var coffeeList: [Coffee] = [
        Coffee(name: "아이스 카라멜 마끼아또", engName: "Iced Caramel Macciato", imageName: "caramerlCold", text: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: 6100, option: .hotIced),
        Coffee(name: "카라멜 마끼아또", engName: "Caramel Macciato", imageName: "caramerHot", text: "향긋한 바닐라 시럽과 따뜻한 스팀 밀크 위에 풍성한 우유 거품을 얹고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: 6100, option: .hotIced),
        Coffee(name: "아이스 카페 아메리카노", engName: "Iced Caffe Imericano", imageName: "americanoCold", text: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피", price: 4700, option: .hotIced),
        Coffee(name: "카페 아메리카노", engName: "Caffe Imericano", imageName: "americanoHot", text: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피", price: 4700, option: .hotIced),
        Coffee(name: "에스프레소 콘 파나", engName: "Espresso Con Panna", imageName: "confana", text: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: 4100, option: .hotOnly),
        Coffee(name: "에스프레소 마끼아또", engName: "Espresso Macciato", imageName: "macchiato", text: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료", price: 3900, option: .icedOnly),
       
    ]
}
