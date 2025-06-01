//
//  ShopViewModel.swift
//  Starbucks_App_
//
//  Created by 김지우 on 4/10/25.
//

import Foundation
import Observation

@Observable
class ShopViewModel: ObservableObject{
    
    var Banners: [BannerModel] = [
        BannerModel(imageName: "cakebanner"),
        BannerModel(imageName: "tripbanner"),
        BannerModel(imageName: "valentinebanner")

    ]
    
    var Products: [CardModel] = [
        CardModel(imageName: "tumbler", title: "텀블러"),
        CardModel(imageName: "coffeesupplies", title: "커피 용품"),
        CardModel(imageName: "presentset", title: "선물세트"),
        CardModel(imageName: "thermos", title: "보온병"),
        CardModel(imageName: "mugcup", title: "머그/컵"),
        CardModel(imageName: "lifestyle", title: "라이프스타일")

    ]
    
    var BestItems : [CardModel] = [
        CardModel(imageName:"mug_sleeve", title:"그린 사이렌 슬리브 머그\n355ml"),
        CardModel(imageName:"mug_greenclassic", title:"그린 사이렌 클래식 머그\n355ml"),
        CardModel(imageName:"mug_wood", title:"사이렌 머그 앤 우드 소서"),
        CardModel(imageName:"mug_goldreserve", title:"리저브 골드 테일 머그\n355ml"),
        CardModel(imageName:"mug_blackandgold", title:"블랙 앤 골드 머그 473ml"),
        CardModel(imageName:"mug_blackring", title:"블랙 링 머그 355ml"),
        CardModel(imageName:"mug_lion", title:"북청사자놀음 데미머그\n89ml"),
        CardModel(imageName:"mug_set", title:"서울 제주 데미머그 세트")
    
    ]
    
    var NewProducts: [CardModel] = [
        CardModel(imageName:"mug_dot237", title:"그린 사이렌 도트 머그\n237ml"),
        CardModel(imageName:"mug_dot355", title:"그린 사이렌 도트 머그\n355ml"),
        CardModel(imageName:"minimugset", title:"홈 카페 미니 머그 세트"),
        CardModel(imageName:"glassset", title:"홈 카페 글라스 세트")
        ]
        

    
    
    
}
