//
//  RecommendViewModel.swift
//  UMC_Starbucks
//
//  Created by 이서현 on 4/3/25.
//

import Foundation
import SwiftUI



class CoffeeViewModel: ObservableObject {
    @AppStorage("nickname") var nickname: String = "(작성한 닉네임)"
    //var homeViewName: String { nickname.isEmpty ? "(설정 닉네임)" : nickname }
    
    var selectMenu: CoffeeModel? = CoffeeModel(title: "에스프레소 콘 파나", engTitle: "Espresso Con Panna", content: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: "4,100", choice: .hot,image: "conPanna", imageD: "confana")
    let recommendCoffeeList: [CoffeeModel] = [
        CoffeeModel(title: "에스프레소 콘 파나", engTitle: "Espresso Con Panna", content: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: "4,100", choice: .hot, image: "conPanna", imageD: "confana") ,
        
        CoffeeModel(title: "에스프레소 마끼야또", engTitle: "Espresso Macchiato", content: "신선한 에스프레소 샷에 우유 거품을 살짝 얹은 커피 음료로서, 강렬한 에스프레소의 맛과 우유의 부드러움을 같이 즐길 수 있는 커피 음료", price: "3,900", choice: .iced, image: "espressoMacchiato", imageD: "macchiato"),
        
        CoffeeModel(title: "아이스 카페 아메리카노", engTitle: "Iced Caffe Americano", content: "진한 에스프레소에 시원한 정수물과 얼음을 더하여 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피", price: "4,700", choice: .both, image: "icedAmericano", imageD: "americanoCold"),
    
        CoffeeModel(title: "카페 아메리카노", engTitle: "Caffe Americano", content: "진한 에스프레소와 뜨거운 물을 섞어 스타벅스의 깔끔하고 강렬한 에스프레소를 가장 부드럽게 잘 느낄 수 있는 커피", price: "4,700", choice: .both, image: "hotAmericano", imageD: "americanoHot"),
        
        CoffeeModel(title: "아이스 카라멜 마끼아또", engTitle: "Iced Caramel Macchiato", content: "향긋한 바닐라 시럽과 시원한 우유에 어름을 넣고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: "6,100", choice: .both, image: "icedCaramel", imageD: "caramelCold") ,
        
        CoffeeModel(title: "카라멜 마끼아또", engTitle: "Caramel Macchiato", content: "향긋한 바닐라 시럽과 따뜻한 스팀 밀크 위에 풍성한 우유 거품을 얹고 점을 찍듯이 에스프레소를 부은 후 벌집 모양으로 카라멜 드리즐을 올린 달콤한 커피 음료", price: "6,100", choice: .both, image: "hotCaramel", imageD: "caramelHot")
    
    
        
        
        
        
    ]
    
    
}
