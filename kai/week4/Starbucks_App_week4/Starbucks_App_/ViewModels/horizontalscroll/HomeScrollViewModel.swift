//
//  RecommendViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/7/25.
//

import Foundation


//Home에 있는 가로 스크롤 뷰의 정보가 포함되어 있는 뷰모델
//홈에서 이 HomeScrollViewModel만 불러오면 커피 추천 메뉴 스크롤뷰, 디저트 스크롤뷰에 대한 정보를 모두 가져올 수 있다
//기존에는 두 개의 뷰모델로 분리해놨었지만, 하나로 통합하는 것이 코드가 더 단순해서 수정함!
@Observable
class HomeScrollViewModel {
    
    var coffeeCard: [CardModel] = [
        CardModel(imageName: "conpanna", title: "에스프레소 콘파냐"),
        CardModel(imageName: "machiato", title: "에스프레소 마키아또"),
        CardModel(imageName: "americano", title: "아이스 카페아메리카노"),
        CardModel(imageName: "americano_hot", title: "카페 아메리카노"),
        CardModel(imageName: "caramel_ice", title: "아이스 캬라멜 마키아또"),
        CardModel(imageName: "caramel_hot", title: "캬라멜 마키아또")

    ]
    
    var desertCard: [CardModel] = [
        CardModel(imageName: "nuttycrossant", title: "너티 크루아상"),
        CardModel(imageName: "spicysausage", title: "매콤 소시지 불고기"),
        CardModel(imageName: "minipie", title: "미니 리프 파이"),
        CardModel(imageName: "chocolate", title: "뺑 오 쇼콜라"),
        CardModel(imageName: "sausagepie", title: "소시지&올리브 파이")
    ]
    
}


