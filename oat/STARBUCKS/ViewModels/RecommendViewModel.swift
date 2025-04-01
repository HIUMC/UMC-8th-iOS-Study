//
//  recommendViewModel.swift
//  STARBUCKS
//
//  Created by 신민정 on 3/28/25.
//

import Foundation
import SwiftUI

class RecommendViewModel: ObservableObject  {
    @AppStorage("nickname") var storedNickname : String = ""
    var recommendMenu : [DetailModel] = [
        DetailModel(
            nameKR: "에스프레소 콘 파나 ",
            nameEN: "Espresso Con Panna",
            cardImageName:"conPanna",
            detailImageName: "coffee5",
            description: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료",
            price: "4,100",
            options: [.hot]),
        DetailModel(
            nameKR: "에스프레소 마끼아또",
            nameEN: "Espresso Macchiato",
            cardImageName: "Macchiato",
            detailImageName: "coffee6",
            description: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료",
            price: "3,900",
            options: [.iced]),
        DetailModel(
            nameKR: "아이스 카페 아메리카노 ",
            nameEN: "Iced Caffe Americano",
            cardImageName:"iceAmericano",
            detailImageName: "coffee3",
            description: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피",
            price: "4,700",
            options: [.iced, .hot]),
        DetailModel(
            nameKR: "카페 아메리카노 ",
            nameEN: "Caffe Americano",
            cardImageName: "hotAmericano",
            detailImageName: "coffee4",
            description: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피",
            price: "4,700",
            options: [.iced, .hot]),
        DetailModel(nameKR: "아이스 캬라멜 마끼아또",
                    nameEN: "Iced Caramel Macchiato",
                    cardImageName:"iceCaramel",
                    detailImageName: "coffee1",
                    description: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료",
                    price: "6,100",
                    options: [.iced, .hot]),
        DetailModel(nameKR: "카라멜 마끼아또",
                    nameEN: "Caramel Macchiato",
                    cardImageName:"Caramel",
                    detailImageName: "coffee2",
                    description: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료",
                    price: "6,100",
                    options: [.iced, .hot]),
        
    ]
    var homeNickname: String {
        storedNickname.isEmpty ? "(설정 닉네임)" : storedNickname
    }
    
}
