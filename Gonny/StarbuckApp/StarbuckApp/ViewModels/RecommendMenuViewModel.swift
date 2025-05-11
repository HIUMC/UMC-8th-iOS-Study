//
//  RecommendMenuViewModel.swift
//  StarbuckApp
//
//  Created by 박병선 on 4/3/25.
//
/*
 Model: 데이터를 담는 그릇
 RecommendMenu는 데이터를 표현하는 구조체이니까, SwiftUI 뷰와 직접적인 의존이 없도록 뷰 관련 타입(Image)은 피하고, 다음처럼 선언하는 게 좋음
 */
import Foundation
import SwiftUI


class RecommendMenuViewModel:ObservableObject {
    @AppStorage("nickname") var nickname: String = "(작성된 닉네임)"
   
    let recommendMenus: [RecommendMenu] = [
        RecommendMenu(name: "에스프레소 콘파냐", imageName: "coffee1"),
        RecommendMenu(name: "에스프레소 마끼야또", imageName: "coffee2"),
        RecommendMenu(name: "아이스 카페 아메리카노", imageName: "coffee3"),
        RecommendMenu(name: "카페 아메리카노", imageName: "coffee4"),
        RecommendMenu(name: "아이스 카라멜 마끼야또", imageName: "coffee5"),
        RecommendMenu(name: "카라멜 마끼야또", imageName: "coffee6")
    ]
}
